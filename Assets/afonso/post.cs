using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class post : MonoBehaviour
{
    public Material material;
    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, material);
    }
}
