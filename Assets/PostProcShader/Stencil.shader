Shader "Custom/Stencil"
{
    Properties
    {
         _MainTex ("Albedo (RGB)", 2D) = "white" {}
         _Color("Color",Color) = (0,0,0,0) 
        [Header(Stencil)]
		_Stencil ("Stencil ID [0;255]", Float) = 0
        [Enum(UnityEngine.Rendering.CompareFunction)] _StencilComp ("Stencil Comparison", Int) = 3
		[Enum(UnityEngine.Rendering.StencilOp)] _StencilOp ("Stencil Operation", Int) = 0

        [Toggle]
        _Alpha("Alpha",Int)=0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        

        LOD 200

     

        Stencil
		{
			Ref [_Stencil]
			Comp [_StencilComp]
			Pass [_StencilOp]
		}

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows 

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

       int _Alpha;
       fixed4 _Color;


        void surf (Input IN, inout SurfaceOutputStandard o)
        {
        fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c;

          
              //o.Alpha = 0;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
