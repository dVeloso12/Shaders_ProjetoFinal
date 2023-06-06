// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Custom/OceanShader 1"
{
   Properties {

		[Header(Ocean Textures )] 
		[Space]
		_WaterBackground ("Ocean Color", Color) = (1,1,1,1)
        _Alpha ("Alpha",Range(0,1)) = 1
        _Metallic ("Metallic",Range(0,1)) = 1
		_Normal1("Ocean Normal 1",2D) = "defaulttexture"{}
		_OceanSpeed("OCean Speed", Vector) = (0.03, 0.03, 0, 0)

		[Header(Ocean Math)] 
		[Space]
        _Steepness ("Stepness" ,Range(0,1)) = 1
        _Wavelengh ("Wave Length" ,Float) = 10
        _Speed ("Speed",Float) = 1
        _Direction("Direction",Vector) = (1,0,0,0)
		[Header(Depth)] 
		[Space]
		_WaterFogColor ("Water Fog Color", Color) = (0, 0, 0, 0)
		_WaterFogDensity ("Water Fog Density", Range(0, 2)) = 0.1
		[Header(Foam Edges)] 
		[Space]
		_ShallowColor("Depth Gradient Shallow", Color) = (0.325, 0.807, 0.971, 0.725)
		_FoamColor("Foam Color", Color) = (1, 1, 1, 1)
		
		_DepthMaxDistance("Depth Maximum Distance", Float) = 1
        _FoamDistance ("Foam Distance",Float) = 1
		_FoamTexture("Noise Texture",2D) = "defaulttexture"{}

		[Header(Foam Waves)] 
		[Space]
		_WaveFoamDistance ("Wave Foam Distance",Range(0,100)) = 1
        _WaveFoamDensity ("Wave Foam Density",Range(0,100)) = 1
	}
	SubShader {
		Tags { "RenderType"="Transparent" "Queue"="Transparent" }
		LOD 200

		GrabPass {"_WaterBackground"}

		CGPROGRAM
		#pragma surface surf Standard alpha vertex:vert addshadow finalcolor:ResetAlpha
		#pragma target 3.0

		#include "LookingThroughWater.cginc"

		#define PI 3.14

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
			float2 uv_FoamTexture;
			float4 screenPos;
			float2 uv_Normal1;
			float3 viewNormal;
			float3 localPos;
	
		};

		    fixed4 _OceanColor;
			sampler2D _Normal1;
            float4 _MainTex_ST;
            float _Steepness;
            float _Wavelengh;
            float _Speed;
            float2 _Direction;
			float _Alpha;
			float _FoamDistance;

			float4 _ShallowColor;
			float4 _FoamColor;
			float2 _OceanSpeed;
			float _WaveFoamDistance;
			float _WaveFoamDensity;
			float _DepthMaxDistance;
			float _Metallic;

		void vert(inout appdata_full vertexData,out Input o) {
			UNITY_INITIALIZE_OUTPUT(Input,o);
		 float k = (2 * PI) / (_Wavelengh);
         float speed = sqrt(9.8 / k) * _Speed;
         float2 d = normalize(_Direction);

         float2 dotp = dot(d,vertexData.vertex.xz);

         float f = k * (dotp - speed * _Time.y );

         float a = _Steepness / k;

         vertexData.vertex.y = (a * sin(f));
         vertexData.vertex.x += (d.x * (a * cos(f)));
         vertexData.vertex.z +=  (d.y * (a * cos(f)));
		o.localPos = vertexData.vertex.xyz;
		 
         float3 tangent = normalize(float3(1- k * _Steepness * sin(f),k * _Steepness * cos(f),0));
         float3 binormal = float3(-d.x * d.y * (_Steepness * sin(f)),d.y * (_Steepness * cos(f)),1-d.y * d.y * (_Steepness * sin(f)));

         float3 normal = normalize(cross(binormal,tangent));

		}

		void surf (Input IN, inout SurfaceOutputStandard o) {
			
			float existingDepth01 = tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(IN.screenPos)).r;
			float existingDepthLinear = LinearEyeDepth(existingDepth01);
			float depthDifference = existingDepthLinear - IN.screenPos.w;

			float waterDepthDifference01 = saturate(depthDifference / _DepthMaxDistance);
			float4 waterColor = lerp(_ShallowColor, _WaterFogColor, waterDepthDifference01);
	
			float2 noiseUVFoam = float2(IN.uv_FoamTexture.x + _Time.y * _OceanSpeed.x, IN.uv_FoamTexture.y + _Time.y * _OceanSpeed.y);
			float2 normalUV = float2(IN.uv_Normal1.x + _Time.y * _OceanSpeed.x, IN.uv_Normal1.y + _Time.y * _OceanSpeed.y);

			float surfaceNoiseSample = tex2D(_FoamTexture, noiseUVFoam).r;
			

			float foamDepthDifference01 = saturate(depthDifference / _FoamDistance);
			float surfaceNoiseCutoff = foamDepthDifference01 * 1;

			float surfaceNoise = surfaceNoiseSample > surfaceNoiseCutoff ? 1 : 0;

			o.Albedo = waterColor + (_FoamColor* surfaceNoise);
			o.Alpha = _Alpha;
			
			if(max(0,IN.localPos.y))
			{
			float surfaceNoiseSampleF = tex2D(_FoamTexture, IN.uv_FoamTexture).r;
			float surfaceNoiseCutoffF = saturate(_WaveFoamDistance / _WaveFoamDensity);
			float surfaceNoiseF = surfaceNoiseSampleF > surfaceNoiseCutoffF ? 1 : 0;
			o.Albedo += _FoamColor * surfaceNoiseF;
			
			}
			o.Smoothness = 1-_Metallic;
			o.Normal = tex2D(_Normal1,normalUV);
			o.Emission = ColorBelowWater(IN.screenPos) * (1 - o.Alpha);
			
			
		}

		void ResetAlpha (Input IN, SurfaceOutputStandard o, inout fixed4 color) {
			color.a = 1;
		}
		ENDCG
	}
	
}
