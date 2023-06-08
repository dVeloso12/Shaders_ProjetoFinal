Shader "Unlit/DeliverShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _slide("slider", Range(0, 10)) = 1
        _slideyaw("slideryaw", Range(0, 360)) = 1
        _slidePitch("sliderPitch", Range(0, 360)) = 1
        _slideRoll("sliderRoll", Range(0, 360)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100
        //geral pass 
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };



            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _slide;
            float _slideyaw;
            float _slidePitch;
            float _slideRoll;

            float3 rotX(float3 pontoEntrada, float graus) {
            
            graus = (graus*3.14)/180;
            float3x3 matrizRotation = {1,0,0,
                      0,cos(graus),-sin(graus),
                      0,sin(graus),cos(graus)
                     };

             return mul(matrizRotation, pontoEntrada);
            
            }

            float3 rotGeral(float3 pontoEntradaGeral, float yaw, float pitch, float roll){
            
            
            yaw = (yaw*3.14)/180;
            pitch = (pitch*3.14)/180;
            roll = (roll*3.14)/180;
            float3x3 matrizGeral = {cos(yaw) * cos(pitch), cos(yaw) * sin(pitch) * sin(roll) - sin(yaw) * cos(roll), cos(yaw) * sin(pitch) * cos(roll) + sin(yaw) * sin(roll),
                                  sin(yaw) * cos(pitch), sin(yaw) * sin(pitch) * sin(roll) + cos(yaw) * cos(roll), sin(yaw) * sin(pitch) * cos(roll) - cos(yaw) * sin(roll),
                                  -sin(pitch), cos(pitch) * sin(roll), cos(pitch) * cos(roll)
                                };
            return mul(matrizGeral, pontoEntradaGeral);
            
            }


            v2f vert (appdata v)
            {
                v2f o;
                v.vertex.xyz = rotGeral(v.vertex.xyz, _slideyaw,_slidePitch,_slideRoll);
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                return col;
            }
            ENDCG
        }
    }
}
