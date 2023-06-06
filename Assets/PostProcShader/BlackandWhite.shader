Shader "Hidden/BlackandWhite"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _RenderTex ("RenTexture", 2D) = "white" {}

        [HideInInspector]
        _TurnOn("On",int)= 0

         [Header(Stencil)]
		_Stencil ("Stencil ID [0;255]", Float) = 0
        [Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Stencil Comparison", Int) = 3
		[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp ("Stencil Operation", Int) = 0
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always
        Tags { "RenderType"="Opaque" }
        Pass
        {

  //        Stencil
		//{
		//	Ref [_Stencil]
		//	Comp [_StencilComp]
		//	Pass [_StencilOp]
		//}

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

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
            sampler2D _RenderTex;
            int _TurnOn;

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                fixed4 Rcol = tex2D(_RenderTex, i.uv);

                fixed bluecol= (col.r+col.b+col.g)/3;
               
                if(_TurnOn!=0){
                col.rgb=bluecol;

                if(Rcol.a!=0){
                fixed bluecol= (Rcol.r+Rcol.b+Rcol.g)/3;
                col.rgb=0;
                col.g=bluecol;
                col.r=bluecol/5;
                col.b=bluecol;
                //col.b=1;
                }
                }
             
                
                return 
                col;
            }
            ENDCG
        }
    }
}
