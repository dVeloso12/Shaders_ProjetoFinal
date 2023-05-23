Shader "Custom/OceanShader 1"
{
   Properties {

		[Header(Ocean Textures )] 
		[Space]
		_OceanColor ("Ocean Color", Color) = (1,1,1,1)
		[Header(Ocean Math)] 
		[Space]
        _Steepness ("Stepness" ,Range(0,1)) = 1
        _Wavelengh ("Wave Length" ,Float) = 10
        _Speed ("Speed",Float) = 1
        _Direction("Direction",Vector) = (1,0,0,0)
	}
	SubShader {
		Tags { "RenderType"="Transparent" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows vertex:vert addshadow
		#pragma target 3.0


		#define PI 3.14


		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;

		   fixed4 _OceanColor;
            float4 _MainTex_ST;
            float _Steepness;
            float _Wavelengh;
            float _Speed;
            float2 _Direction;

		void vert(inout appdata_full vertexData) {

		 float k = (2 * PI) / (_Wavelengh);
         float speed = sqrt(9.8 / k) * _Speed;
         float2 d = normalize(_Direction);

         float2 dotp = dot(d,vertexData.vertex.xz);

         float f = k * (dotp - speed * _Time.y);

         float a = _Steepness / k;

         vertexData.vertex.y = a * sin(f);
         vertexData.vertex.x += d.x * (a * cos(f));
         vertexData.vertex.z += d.y * (a * cos(f));
              
         float3 tangent = normalize(float3(1- k * _Steepness * sin(f),k * _Steepness * cos(f),0));
         float3 binormal = float3(-d.x * d.y * (_Steepness * sin(f)),d.y * (_Steepness * cos(f)),1-d.y * d.y * (_Steepness * sin(f)));

         float3 normal = normalize(cross(binormal,tangent));
         vertexData.normal = normal;
              
		
		}
		void surf (Input IN, inout SurfaceOutputStandard o) {
			o.Albedo.rgb = _OceanColor;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
