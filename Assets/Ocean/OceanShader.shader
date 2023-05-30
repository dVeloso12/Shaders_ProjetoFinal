// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Unlit/OceanShader"
{
    Properties
    {
        _OceanColor ("Ocean Color", Color) = (1,1,1,1)

        _Steepness ("Stepness" ,Range(0,1)) = 1
        _Wavelengh ("Wave Length" ,Float) = 10
        _Speed ("Speed",Float) = 1
        _Direction("Direction",Vector) = (1,0,0,0)
        

    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {

  
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
  

            #include "UnityCG.cginc"
            
            #define PI 3.14
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float3 normal : TEXCOORD1;
                float4 vertex : SV_POSITION;
                float3 worldPos : TEXCOORD2;
            };

            fixed4 _OceanColor;
            float4 _MainTex_ST;
            float _Steepness;
            float _Wavelengh;
            float _Speed;
            float2 _Direction;


            v2f vert (appdata v)
            {
                v2f o;
                
                float k = (2 * PI) / (_Wavelengh);
                float c = sqrt(9.8 / k) * _Speed;
                float2 d = normalize(_Direction);

              
                float2 dotp = dot(d,v.vertex.xz);

                float f = k * (dotp - c * _Time.y);

                float a = _Steepness / k;

                v.vertex.y = a * sin(f);
                v.vertex.x += d.x * (a * cos(f));
                v.vertex.z += d.y * (a * cos(f));
              
              float3 tangent = normalize(float3(1- k * _Steepness * sin(f),k * _Steepness * cos(f),0));
              float3 binormal = float3(-d.x * d.y * (_Steepness * sin(f)),d.y * (_Steepness * cos(f)),1-d.y * d.y * (_Steepness * sin(f)));

              float3 normal = normalize(cross(binormal,tangent));
              o.normal = normal;

                o.vertex = UnityObjectToClipPos(v.vertex);
                //o.uv = TRANSFORM_TEX(v.uv, _MainTex);
              
                
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                //// sample the texture
                //fixed4 col = tex2D(_MainTex, i.uv);

                float wave = cos((i.uv.y - _Time.y * 0.1) * 6.2831855 * 5) * 0.5 + 0.5;

                return _OceanColor; 
             

            }
            ENDCG
        }
    }
}
