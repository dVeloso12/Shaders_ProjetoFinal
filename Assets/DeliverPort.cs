using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DeliverPort : MonoBehaviour
{
    public int Number;
    public Material Wireframe;
    Material otherMat;
    bool turnOn = false;
    Renderer render;
    DeliverShaderController dev;
   
    public bool RightStation;
    void Start()
    {
        render = GetComponent<Renderer>();
        otherMat = render.material;
        dev = GetComponent<DeliverShaderController>();
    }

    // Update is called once per frame
    void Update()
    {
        if (GameManager.Instance.Deliver == Number)
        {
            RightStation = true;
            gameObject.layer = 6;
        }
        else
        {
            RightStation = false;
            gameObject.layer=7;
        }

         
        if (Input.GetKeyDown(KeyCode.E))
        {

            turnOn = !GameManager.Instance.FocusVision;
            if (turnOn && RightStation)
            {
                render.material = Wireframe;
            }
            else
                render.material = otherMat;
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (RightStation)
        {
            GameManager.Instance.DeliveredCrate();
            dev.AnimationPlay(0);
        }
    }
}
