Shader "Unlit/WireFrame"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _WireframeColor("Wirefram colour", color) = (0.5, 0.5, 0.5, 1.0)
        _WireframeWidth("Wireframe Width", float) = 0.05
        _WireframeBackColour("Wireframe back colour", color) = (0.5, 0.5, 0.5, 1.0)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Transparent"}
        LOD 100
        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
        Cull Front
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma geometry geom
         


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

            struct g2f{
            float4 pos : SV_POSITION;
                float3 barycentric : TEXTCOORD0;
            };


            sampler2D _MainTex;
            float4 _MainTex_ST;
            fixed4 _WireframeColor;
            float _WireframeWidth;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
             
                return col;
            }

             [maxvertexcount(3)]
            void geom(triangle v2f IN[3], inout TriangleStream<g2f> triStream) {
                g2f o;
                o.pos = IN[0].vertex;
                o.barycentric = float3(1.0, 0.0, 0.0);
                triStream.Append(o);
                o.pos = IN[1].vertex;
                o.barycentric = float3(0.0, 1.0, 0.0);
                triStream.Append(o);
                o.pos = IN[2].vertex;
                o.barycentric = float3(0.0, 0.0, 1.0);
                triStream.Append(o);
            }

             fixed4 frag(g2f i) : SV_Target
            {
                // Find the barycentric coordinate closest to the edge.
                float closest = min(i.barycentric.x, min(i.barycentric.y, i.barycentric.z));
                // Set alpha to 1 if within the threshold, else 0.
                float alpha = step(closest, _WireframeWidth);
                // Set to our backwards facing wireframe colour.
                fixed4 col;
                col=_WireframeColor;
                col.w=alpha;

                return col;
            }



            ENDCG
        }

        Pass
        {
        Cull Back
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma geometry geom
         


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

            struct g2f{
            float4 pos : SV_POSITION;
                float3 barycentric : TEXTCOORD0;
            };


            sampler2D _MainTex;
            float4 _MainTex_ST;
            fixed4 _WireframeBackColor;
            float _WireframeWidth;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
             
                return col;
            }

             [maxvertexcount(3)]
            void geom(triangle v2f IN[3], inout TriangleStream<g2f> triStream) {
                g2f o;
                o.pos = IN[0].vertex;
                o.barycentric = float3(1.0, 0.0, 0.0);
                triStream.Append(o);
                o.pos = IN[1].vertex;
                o.barycentric = float3(0.0, 1.0, 0.0);
                triStream.Append(o);
                o.pos = IN[2].vertex;
                o.barycentric = float3(0.0, 0.0, 1.0);
                triStream.Append(o);
            }

             fixed4 frag(g2f i) : SV_Target
            {
                // Find the barycentric coordinate closest to the edge.
                float closest = min(i.barycentric.x, min(i.barycentric.y, i.barycentric.z));
                // Set alpha to 1 if within the threshold, else 0.
                float alpha = step(closest, _WireframeWidth);
                // Set to our backwards facing wireframe colour.
                fixed4 col;
                col=_WireframeBackColor;
                col.w=alpha;

                return col;
            }



            ENDCG
        }
    }
}
