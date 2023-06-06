using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GeneratePlane : MonoBehaviour
{
        public int Size = 20;
        public float Scale = 1.0f;
        private Mesh mesh;
        private Vector3[] vertices;
        private int[] triangles;
        private Vector2[] uvs;
        private int verticiesLength = 0;

    [SerializeField] private Transform debugSphere;
    WaterController controller;

    private void Start()
    {
        mesh = new Mesh();
        GetComponent<MeshFilter>().mesh = mesh;
        verticiesLength = (Size + 1) * (Size + 1);
        //controller = GameObject.Find("Water").GetComponent<WaterController>();

        UpdatePlaneVerticies();
        UpdateMesh();
    }

    private void Update()
    {
        //if (debugSphere != null)
        //{
        //    Vector3 newPos = debugSphere.position;
           
        //    debugSphere.position = newPos;
        //}
    }

    void UpdatePlaneVerticies()
    {
        vertices = new Vector3[verticiesLength];
        uvs = new Vector2[vertices.Length];

        float halfSizeX = (Scale* Size) / 2;
        float halfSizeZ = (Scale * Size) / 2;

        int i = 0;
        for (int z = 0; z <= Size; z++)
        {
            for (int x = 0; x <= Size; x++)
            {
                float xPos = (x * Scale) - halfSizeX;
                float zPos = (z * Scale) - halfSizeZ;
                float yPos = 0;

                vertices[i] = new Vector3(xPos, yPos, zPos);

                //if (isUpdatingOnCPU)
                //    vertices[i] += WaterController.current.GetWaveAddition(vertices[i] + transform.position, Time.timeSinceLevelLoad);

                uvs[i] = new Vector2(vertices[i].x, vertices[i].z);
                i++;
            }
        }

        triangles = new int[Size * Size * 6];

        int vert = 0;
        int tris = 0;

        for (int z = 0; z < Size; z++)
        {
            for (int x = 0; x < Size; x++)
            {
                triangles[tris + 0] = vert + 0;
                triangles[tris + 1] = vert + Size + 1;
                triangles[tris + 2] = vert + 1;
                triangles[tris + 3] = vert + 1;
                triangles[tris + 4] = vert + Size + 1;
                triangles[tris + 5] = vert + Size + 2;

                vert++;
                tris += 6;
            }
            vert++;
        }
    }

    void UpdateMesh()
    {
        mesh.Clear();
        mesh.vertices = vertices;
        mesh.triangles = triangles;
        mesh.uv = uvs;
        mesh.RecalculateNormals();
    }
}


