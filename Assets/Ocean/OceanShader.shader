// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Unlit/OceanShader"
{
  //  Properties
  //  {
  //      [Header(Ocean Textures )] 
		//[Space]
		//_WaterBackground ("Ocean Color", Color) = (1,1,1,1)
  //      _Alpha ("Alpha",Range(0,1)) = 1
		//_Normal1("Ocean Normal 1",2D) = "defaulttexture"{}
		//_OceanSpeed("OCean Speed", Vector) = (0.03, 0.03, 0, 0)

		//[Header(Ocean Math)] 
		//[Space]
  //      _Steepness ("Stepness" ,Range(0,1)) = 1
  //      _Wavelengh ("Wave Length" ,Float) = 10
  //      _Speed ("Speed",Float) = 1
  //      _Direction("Direction",Vector) = (1,0,0,0)
		//[Header(Depth)] 
		//[Space]
		//_WaterFogColor ("Water Fog Color", Color) = (0, 0, 0, 0)
		//_WaterFogDensity ("Water Fog Density", Range(0, 2)) = 0.1
		//[Header(Foam)] 
		//[Space]
		//_ShallowColor("Depth Gradient Shallow", Color) = (0.325, 0.807, 0.971, 0.725)
		//_FoamColor("Foam Color", Color) = (1, 1, 1, 1)
		
		//_DepthMaxDistance("Depth Maximum Distance", Float) = 1
  //      _FoamDistance ("Foam Distance",Float) = 1
		//_FoamTexture("Noise Texture",2D) = "defaulttexture"{}
        

  //  }
  //  SubShader
  //  {
  //      Tags { "RenderType"="Transparent" "Queue"="Transparent" }

  //      Pass
  //      {

  
  //          CGPROGRAM
  //          #pragma vertex vert
  //          #pragma fragment frag
  //          // make fog work
  

  //          #include "UnityCG.cginc"
  //          #include "LookingThroughWater.cginc"
            
  //          #define PI 3.14
  //          struct appdata
  //          {
  //              float4 vertex : POSITION;
  //              float2 uv : TEXCOORD0;
  //          };

  //          struct v2f
  //          {
  //              float2 uv : TEXCOORD0;
  //              float3 normal : TEXCOORD1;
  //              float4 vertex : SV_POSITION;
  //              float3 worldPos : TEXCOORD2;

  //          };

  //          fixed4 _OceanColor;
  //          float4 _MainTex_ST;
  //          float _Steepness;
  //          float _Wavelengh;
  //          float _Speed;
  //          float2 _Direction;


  //          v2f vert (appdata v)
  //          {
  //              v2f o;
                
  //              float k = (2 * PI) / (_Wavelengh);
  //              float c = sqrt(9.8 / k) * _Speed;
  //              float2 d = normalize(_Direction);

              
  //              float2 dotp = dot(d,v.vertex.xz);

  //              float f = k * (dotp - c * _Time.y);

  //              float a = _Steepness / k;

  //              v.vertex.y = a * sin(f);
  //              v.vertex.x += d.x * (a * cos(f));
  //              v.vertex.z += d.y * (a * cos(f));
              
  //            float3 tangent = normalize(float3(1- k * _Steepness * sin(f),k * _Steepness * cos(f),0));
  //            float3 binormal = float3(-d.x * d.y * (_Steepness * sin(f)),d.y * (_Steepness * cos(f)),1-d.y * d.y * (_Steepness * sin(f)));

  //            float3 normal = normalize(cross(binormal,tangent));
  //            o.normal = normal;

  //              o.vertex = UnityObjectToClipPos(v.vertex);
  //              //o.uv = TRANSFORM_TEX(v.uv, _MainTex);
              
                
  //              return o;
  //          }

  //          fixed4 frag (v2f i) : SV_Target
  //          {
  // //         fixed3 col;
  // //             float existingDepth01 = tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(IN.screenPos)).r;
		//	//float existingDepthLinear = LinearEyeDepth(existingDepth01);
		//	//float depthDifference = existingDepthLinear - IN.screenPos.w;

		//	//float waterDepthDifference01 = saturate(depthDifference / _DepthMaxDistance);
		//	//float4 waterColor = lerp(_ShallowColor, _WaterFogColor, waterDepthDifference01);
	
		//	//float2 noiseUVFoam = float2(IN.uv_FoamTexture.x + _Time.y * _OceanSpeed.x, IN.uv_FoamTexture.y + _Time.y * _OceanSpeed.y);
		//	//float2 normalUV = float2(IN.uv_Normal1.x + _Time.y * _OceanSpeed.x, IN.uv_Normal1.y + _Time.y * _OceanSpeed.y);

		//	//float surfaceNoiseSample = tex2D(_FoamTexture, noiseUVFoam).r;
		//	//surfaceNoiseSample = surfaceNoiseSample;

		//	//float foamDepthDifference01 = saturate(depthDifference / _FoamDistance);
		//	//float surfaceNoiseCutoff = foamDepthDifference01 * 1;

		//	//float surfaceNoise = surfaceNoiseSample > surfaceNoiseCutoff ? 1 : 0;

		//	//col.rgb = waterColor + (_FoamColor* surfaceNoise);
			
			
		//	//col.a = _Alpha;
		//	//col.Emission = ColorBelowWater(IN.screenPos) * (1 - o.Alpha);

		//	//col.Normal = tex2D(_Normal1,normalUV);
					
		//}

		//void ResetAlpha (Input IN, SurfaceOutputStandard o, inout fixed4 color) {
		//	color.a = 1;
		//}
             

    //        }
    //        ENDCG
    //    }
    //}
}
