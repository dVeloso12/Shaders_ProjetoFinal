using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Flag : MonoBehaviour
{
    public int Number;
    GameObject flag;
    public bool Deliver;
    void Start()
    {
        flag = transform.GetChild(0).gameObject;
    }

    // Update is called once per frame
    void Update()
    {
        if ((GameManager.Instance.Pickup==Number&&!Deliver)||(GameManager.Instance.Deliver == Number&&Deliver))
        {
            gameObject.layer = 6;
            flag.layer = 6;
        }
        else
        {
            gameObject.layer = 7;
            flag.layer = 7;
        }

    }
}
