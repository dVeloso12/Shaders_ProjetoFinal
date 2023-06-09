using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WireframeSwitch : MonoBehaviour
{
    public Material Wireframe;
    Material otherMat;
    bool turnOn = false;
    Renderer render;
    void Start()
    {
        render = GetComponent<Renderer>();
        otherMat = render.material;
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.E))
        {
            turnOn = !turnOn;
            if (turnOn)
            {
                render.material = Wireframe;
            }
            else
                render.material = otherMat;
        }
    }
}
