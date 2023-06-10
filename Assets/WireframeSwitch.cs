using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WireframeSwitch : MonoBehaviour
{
    public Material Wireframe;
    Material otherMat;
    bool turnOn = false;
    Renderer render;
    public bool CanSwap;
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
            
            turnOn = GameManager.Instance.FocusVision;
            if (turnOn)
            {
                render.material = Wireframe;
            }
            else
                render.material = otherMat;
        }
    }
}
