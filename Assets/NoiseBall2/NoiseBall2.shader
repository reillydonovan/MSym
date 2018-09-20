﻿Shader "Custom/NoiseBall2"
{
    Properties
    {
        _Color("Color", Color) = (1, 1, 1, 1)
        _Smoothness("Smoothness", Range(0, 1)) = 0
        _Metallic("Metallic", Range(0, 1)) = 0
        [HDR] _Emission("Emission", Color) = (0, 0, 0)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Cull Off

        CGPROGRAM

        #pragma surface surf Standard vertex:vert addshadow
        #pragma instancing_options procedural:setup
        #pragma target 4.0

        struct appdata
        {
            float4 vertex : POSITION;
            float3 normal : NORMAL;
            float4 tangent : TANGENT;
            float4 texcoord1 : TEXCOORD1;
            float4 texcoord2 : TEXCOORD2;
            uint vid : SV_VertexID;
            UNITY_VERTEX_INPUT_INSTANCE_ID
        };

        struct Input
        {
            float vface : VFACE;
        };

        half4 _Color;
        half _Smoothness;
        half _Metallic;
        half3 _Emission;

        float4x4 _LocalToWorld;
        float4x4 _WorldToLocal;

        #ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED

        StructuredBuffer<float4> _PositionBuffer;
        StructuredBuffer<float4> _NormalBuffer;

        #endif

        void vert(inout appdata v)
        {
            #ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED

            uint id = unity_InstanceID * 3 + v.vid;

            v.vertex.xyz = _PositionBuffer[id].xyz;
            v.normal = _NormalBuffer[id].xyz;

            #endif
        }

        void setup()
        {
            unity_ObjectToWorld = _LocalToWorld;
            unity_WorldToObject = _WorldToLocal;
        }

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            o.Albedo = _Color.rgb;
            o.Metallic = _Metallic;
            o.Smoothness = _Smoothness;
            o.Normal = float3(0, 0, IN.vface < 0 ? -1 : 1);
            o.Emission = _Emission;
        }

        ENDCG
    }
    FallBack "Diffuse"
}
