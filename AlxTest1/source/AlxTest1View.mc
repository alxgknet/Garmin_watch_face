import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.ActivityMonitor;
using Toybox.Position;
using Toybox.Activity;


class AlxTest1View extends WatchUi.WatchFace {

	var cX, cY;
   
    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));

        cX = dc.getWidth() / 2;
        cY = dc.getHeight() / 2;
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Get and show the current time
        var clockTime = System.getClockTime();

        var pm = (clockTime.hour >= 12) ? "pm" : "am";
        var hour = clockTime.hour % 12;
        hour = (hour == 0) ? 12 : hour; 

        var timeString = Lang.format("$1$:$2$", [hour, clockTime.min.format("%02d")]);
        var view = View.findDrawableById("TimeLabel") as Text;
        view.setText(timeString);        
        var pmLabel = View.findDrawableById("PmLabel") as Text;
        pmLabel.setText(pm);

        // Battery
        var battery = System.getSystemStats().battery;
        var batteryString = Lang.format ("$1$%", [battery.format("%i")]);

        // Date
        var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var dateString = Lang.format ("$1$/$2$/$3$", [today.month.format("%02d"), today.day.format("%02d"),  today.year]);

        // Steps
		var info = ActivityMonitor.getInfo();
		var steps = info.steps;
        var stepGoal = info.stepGoal;
		//var stepsString = Lang.format ("$1$ of $2$", [steps.format("%d"),stepGoal.format("%d")]);
		var stepsString = Lang.format ("$1$", [steps.format("%d")]);

        //elevation
        var infoA = Activity.getActivityInfo();
        var altitude = infoA.altitude;
        var elevation = Lang.format ("$1$", [altitude.format("%d")]);

   
        //outut
        var txtTopLeft = dateString;
        var txtTopRight = batteryString;
        var txtBottomLeft = stepsString;
        var txtBottomRight = elevation;

        var lblTopLeft = View.findDrawableById("TopLeftLabel") as Text;
        var lblTopRight = View.findDrawableById("TopRightLabel") as Text;
        lblTopLeft.setText(txtTopLeft);
        lblTopRight.setText(txtTopRight);        

        //test
        // battery = 50;
        // steps = 2000;
        // stepGoal = 5000;
        // altitude = 2000;
 
        var img_battery,img_battery1,img_battery2;
        var img_steps,img_steps1,img_steps2;
        var img_altitude,img_altitude1,img_altitude2,img_altitude0;

       try
        {

            img_battery = Toybox.WatchUi.loadResource(Rez.Drawables.battery) as BitmapResource;
            img_battery1 = Toybox.WatchUi.loadResource(Rez.Drawables.battery1) as BitmapResource;
            img_battery2 = Toybox.WatchUi.loadResource(Rez.Drawables.battery2) as BitmapResource;

            img_steps = Toybox.WatchUi.loadResource(Rez.Drawables.steps) as BitmapResource;
            img_steps1 = Toybox.WatchUi.loadResource(Rez.Drawables.steps1) as BitmapResource;
            img_steps2 = Toybox.WatchUi.loadResource(Rez.Drawables.steps2) as BitmapResource;

            img_altitude0 = Toybox.WatchUi.loadResource(Rez.Drawables.altitude0) as BitmapResource;
            img_altitude = Toybox.WatchUi.loadResource(Rez.Drawables.altitude) as BitmapResource;
            img_altitude1 = Toybox.WatchUi.loadResource(Rez.Drawables.altitude1) as BitmapResource;
            img_altitude2 = Toybox.WatchUi.loadResource(Rez.Drawables.altitude2) as BitmapResource;



            //set bitmaps
            var bmp_battery = View.findDrawableById("battery");
            if (bmp_battery != null && img_battery != null)
            {
                if (battery <= 40)
                {
                    bmp_battery.setBitmap(img_battery);      
                }  
                else if (battery > 40 && battery < 60)
                {
                    bmp_battery.setBitmap(img_battery1);
                }
                else
                {
                    bmp_battery.setBitmap(img_battery2);
                }
            }

            //set steps
            var bmp_steps = View.findDrawableById("steps");
            if (bmp_steps != null && img_steps != null)
            {
                if (steps <= stepGoal*0.3)
                {
                    bmp_steps.setBitmap(img_steps);      
                }  
                else if (battery > stepGoal*0.3 && battery < stepGoal*0.7)
                {
                    bmp_steps.setBitmap(img_steps1);
                }
                else
                {
                    bmp_steps.setBitmap(img_steps2);
                }        
            }

            //set altitude
            var bmp_altitude = View.findDrawableById("altitude");
            if (bmp_altitude != null && img_altitude0 != null)
            {
                if (altitude <= 0)
                {
                    bmp_altitude.setBitmap(img_altitude0);      
                }  
                else if (altitude > 0 && battery <= 100)
                {
                    bmp_altitude.setBitmap(img_altitude);      
                }  
                else if (altitude > 100 && battery < 1000)
                {
                    bmp_altitude.setBitmap(img_altitude1);
                }
                else
                {
                    bmp_altitude.setBitmap(img_altitude2);
                }   
            }
        }
        catch(x)
        {

        }
/**/


        var lblBottomLeft = View.findDrawableById("BottomLeftLabel") as Text;
        var lblBottomRight = View.findDrawableById("BottomRightLabel") as Text;
        lblBottomLeft.setText(txtBottomLeft);
        lblBottomRight.setText(txtBottomRight);



        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }
    

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
