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

        var pm = (clockTime.hour <= 12) ? "am" : "pm";
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

        /*if (latitude != null && longitude != null)
        {
        
            elevation = elevation + Lang.format ("lat:$1$ lon:$2$", [myLocation[0].format("%05d"),[myLocation[1].format("%05d")]);    
        }*/


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

/*
        //set bitmaps
        var bmp_battery = View.findDrawableById("battery") as Bitmap;
        if (battery <= 40)
        {
            bmp_battery.setBitmap(Toybox.WatchUi.loadResource(Rez.Drawables.battery));      
        }  
        else if (battery > 40 && battery < 60)
        {
            bmp_battery.setBitmap(Toybox.WatchUi.loadResource(Rez.Drawables.battery1));
        }
        else
        {
            bmp_battery.setBitmap(Toybox.WatchUi.loadResource(Rez.Drawables.battery2));
        }

        //set steps
        var bmp_steps = View.findDrawableById("steps") as Bitmap;
        if (steps <= stepGoal*0.3)
        {
            bmp_steps.setBitmap(Toybox.WatchUi.loadResource(Rez.Drawables.steps));      
        }  
        else if (battery > stepGoal*0.3 && battery < stepGoal*0.7)
        {
            bmp_steps.setBitmap(Toybox.WatchUi.loadResource(Rez.Drawables.steps1));
        }
        else
        {
            bmp_steps.setBitmap(Toybox.WatchUi.loadResource(Rez.Drawables.steps2));
        }        


        //set altitude
        var bmp_altitude = View.findDrawableById("altitude") as Bitmap;
        if (altitude <= 100)
        {
            bmp_altitude.setBitmap(Toybox.WatchUi.loadResource(Rez.Drawables.altitude));      
        }  
        else if (altitude > 100 && battery < 1000)
        {
            bmp_altitude.setBitmap(Toybox.WatchUi.loadResource(Rez.Drawables.altitude1));
        }
        else
        {
            bmp_altitude.setBitmap(Toybox.WatchUi.loadResource(Rez.Drawables.altitude2));
        }   
*/
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
