package org.opencloudengine.garuda.mesos.marathon.message;

import org.opencloudengine.garuda.mesos.marathon.model.App;

/**
 * Created by swsong on 2015. 8. 9..
 */
public class GetApp {
    private App app;

    public App getApp() {
        return app;
    }

    public void setApp(App app) {
        this.app = app;
    }
}
