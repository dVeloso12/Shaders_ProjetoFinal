Shader "Hidden/colision_post"
{
 Properties
    {
    [HideInInspector]
        _MainTex ("Texture", 2D) = "white" {}
       _MainTex_2 ("Texture_2", 2D) = "white" {}
       _MainTex_3 ("Texture_3", 2D) = "white" {}
        _Controlador ("controlador", Range (0, 0.1)) = 0
         _border_color ("_border_color", Color) = (1,1,1,1)
           [MaterialToggle] _EnableBorderScreen("Enable Border", Float) = 0
     
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

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
                float4 vertex_1:TEXCOORD1;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.vertex_1=v.vertex;
  
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
            float4 _MainTex_TexelSize;
            sampler2D _MainTex_2;
            sampler2D _MainTex_3;
            float _Controlador;
             float _Lado;
            float4 _ColorSquare;
            float4 _border_color;
            float _EnableBorderScreen;
           float _slider;

            fixed4 frag (v2f i) : SV_Target
            {
            
               fixed4 col_2 = tex2D(_MainTex_2, i.uv);
               fixed4 col_3 = tex2D(_MainTex_3, i.uv);
               fixed4 col = tex2D(_MainTex, i.uv);

              //if(_EnableBorderScreen==1)
              //{
              // //_Controlador==0.1f;
              //  // if(_Controlador<0.1f)
              //  //{
              //  //  _Controlador+=0.01*_Time.w;
              //  //}
              //  //else
              //  //{ 
              //  //  _Controlador==0.1f;
              //  //}
              //} 

              //if(_EnableBorderScreen==0)
              //{
              //  if(_Controlador>0)
              //  {
              //    _Controlador-=0.01*_Time.w;
              //  }
                 
              //   if(_Controlador==0||_Controlador<=0)
              //  { 
              //    _Controlador=0;
              //  }
              //}
               col = tex2D(_MainTex, i.uv*(1-col_3*_Controlador));

                if(col_2.a<_Controlador)
                {
                 return _border_color;
                }
             // if(_EnableBorderScreen==0) 
             //{
             //  return col;
             //}

                return col;
            }
            ENDCG
        }
    }
}
