using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PickUpPort : MonoBehaviour
{
    public int Port;
    public Material Wireframe;
    Material otherMat;
    bool turnOn = false;
    Renderer render;
    public bool CanSwap;
   public bool RightStation;
    DeliverShaderController dev;
    void Start()
    {
        render = GetComponent<Renderer>();
        otherMat = render.material;
        dev = GetComponent<DeliverShaderController>();
    }

    // Update is called once per frame
    void Update()
    {
       


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

        if (GameManager.Instance.Pickup == Port)
        {
            RightStation = true;
            gameObject.layer = 6;
        }
        else
        {
            RightStation = false;
            gameObject.layer = 7;
        }
    }

    private void FixedUpdate()
    {
        
    }

    private void OnTriggerEnter(Collider other)
    {
        if (RightStation)
        {
            GameManager.Instance.Deliver = Random.Range(1, GameManager.Instance.TotalDeliver);
            GameManager.Instance.Pickup = -1;
            dev.AnimationPlay(0);
        }
    }
}
