using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class wook_Touch : MonoBehaviour
{
  
    public bool correct = false;

    //public Image imag;

    public static wook_Touch instance;

    private void Awake()
    {
        if (instance == null)
        {
            instance = this;
        }
    }

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
    
    private void OnMouseDown()
    {
        print("click");
        gameObject.GetComponent<MeshRenderer>().enabled = true;

        correct = true;


    }
}
