using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SCManager : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        if (ObjManager.instance != null)
        {
            ObjManager.instance.StopAllCoroutines();
            ObjManager.instance.DetectionCurrentScene();
            ObjManager.instance.entering = false;
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
