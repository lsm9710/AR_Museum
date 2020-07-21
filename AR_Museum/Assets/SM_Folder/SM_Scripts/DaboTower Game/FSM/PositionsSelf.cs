using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PositionsSelf : MonoBehaviour
{
    enum WHOAMI
    {
        work,
        quarry
    }
    WHOAMI state;

    void SwitchState()
    {
        switch (state)
        {
            case WHOAMI.work:
                IAMWorkPos();
                break;
            case WHOAMI.quarry:
                IAMQuarryPos();
                break;
        }
    }

    private void Start()
    {
        if (transform.tag == "WorkPosition") state = WHOAMI.work;
        if (transform.tag == "QuarryingPosition") state = WHOAMI.quarry;
    }
    // Update is called once per frame
    void Update()
    {
        SwitchState();
    }

    public bool atOnce = false;
    void IAMWorkPos()
    {
        if (transform.childCount > 0) WorkPositon_Manager.WP.workPosition.Remove(gameObject);
    }

    void IAMQuarryPos()
    {
        if (transform.childCount > 0) WorkPositon_Manager.WP.quarryPosition.Remove(gameObject);
        else if (transform.childCount <= 0 && atOnce)
        {
            WorkPositon_Manager.WP.quarryPosition.Add(gameObject);
            atOnce = false;
        }
    }
}
