using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class post : MonoBehaviour
{
    public Material material;
    void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        // Read pixels from the source RenderTexture, apply the material, copy the updated results to the destination RenderTexture
        Graphics.Blit(src, dest, material);
        //Graphics.Blit(render, dest, mat);
    }

}
