using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class stamptest : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if(Input.GetKey(KeyCode.Alpha1))
        wook_STAMP_Manager.instance.StampCheckModule(0);

        if (Input.GetKey(KeyCode.Alpha2))
            wook_STAMP_Manager.instance.StampCheckModule(1);

        if (Input.GetKey(KeyCode.Alpha3))
            wook_STAMP_Manager.instance.StampCheckModule(2);

        if (Input.GetKey(KeyCode.Alpha4))
        {
            print("리셋");
            wook_STAMP_Manager.instance.stampCheck[0].SetActive(false);
            wook_STAMP_Manager.instance.stampCheck[1].SetActive(false);
            wook_STAMP_Manager.instance.stampCheck[2].SetActive(false);
        }

    }
}
