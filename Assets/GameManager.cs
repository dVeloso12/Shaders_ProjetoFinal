using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour
{

    public static GameManager Instance { get; private set; }

    public int Deliver;

    public bool FocusVision=false;

    public int Score = 0;

    public int TotalPickup,TotalDeliver;

    public int Pickup;

    private void Awake()
    {
        // If there is an instance, and it's not me, delete myself.

        if (Instance != null && Instance != this)
        {
            Destroy(this);
        }
        else
        {
            Instance = this;
        }
    }
    
    void Start()
    {
        TotalPickup = FindObjectsByType<PickUpPort>(FindObjectsSortMode.None).Length;
        TotalDeliver = FindObjectsByType<DeliverPort>(FindObjectsSortMode.None).Length;
        Pickup = Random.Range(1, TotalPickup);
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.E))
        {
            FocusVision = !FocusVision;
            Debug.Log(FocusVision);

        }
    }

    public void DeliveredCrate()
    {
        Score++;
        Deliver = -1;
        Pickup = Random.Range(1, TotalPickup);
    }
}
