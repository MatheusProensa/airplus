package com.sulake.habbo.quest.seasonalcalendar
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class CalendarArrowButton
   {
      public static const DIRECTION_BACK:int = 0;
      
      public static const UnknownConstFromCalendarArrowButton_Int_1:int = 1;
      
      public static const STATE_INACTIVE:int = 0;
      
      public static const STATE_ACTIVE:int = 1;
      
      public static const STATE_HILITE:int = 2;
      
      private static const PRESSED_OFFSET_PIXELS:Point = new Point(1,1);
      
      private var _window:IBitmapWrapperController;
      
      private var _callback:Function;
      
      private var UnknownVarFromCalendarArrowButton_Int_1:int = 0;
      
      private var _pressed:Boolean = false;
      
      private var UnknownVarFromCalendarArrowButton_Point_1:Point;
      
      private var UnknownVarFromCalendarArrowButton_BitmapData_1:BitmapData;
      
      private var UnknownVarFromCalendarArrowButton_BitmapData_2:BitmapData;
      
      private var UnknownVarFromCalendarArrowButton_BitmapData_3:BitmapData;
      
      public function CalendarArrowButton(param1:IAssetLibraryCollection, param2:IBitmapWrapperController, param3:int, param4:Function)
      {
         super();
         _window = param2;
         _window.procedure = procedure;
         _callback = param4;
         switch(param3)
         {
            case 0:
               UnknownVarFromCalendarArrowButton_BitmapData_2 = BitmapData(param1.getAssetByName("arrow_back_active").content).clone();
               UnknownVarFromCalendarArrowButton_BitmapData_1 = BitmapData(param1.getAssetByName("arrow_back_inactive").content).clone();
               UnknownVarFromCalendarArrowButton_BitmapData_3 = BitmapData(param1.getAssetByName("arrow_back_hilite").content).clone();
               break;
            case 1:
               UnknownVarFromCalendarArrowButton_BitmapData_2 = BitmapData(param1.getAssetByName("arrow_next_active").content).clone();
               UnknownVarFromCalendarArrowButton_BitmapData_1 = BitmapData(param1.getAssetByName("arrow_next_inactive").content).clone();
               UnknownVarFromCalendarArrowButton_BitmapData_3 = BitmapData(param1.getAssetByName("arrow_next_hilite").content).clone();
         }
         UnknownVarFromCalendarArrowButton_Point_1 = new Point(_window.x,_window.y);
         updateWindow();
      }
      
      public function dispose() : void
      {
         UnknownVarFromCalendarArrowButton_BitmapData_2 = null;
         UnknownVarFromCalendarArrowButton_BitmapData_3 = null;
         UnknownVarFromCalendarArrowButton_BitmapData_1 = null;
         _window.procedure = null;
         _window = null;
         _callback = null;
      }
      
      public function activate() : void
      {
         if(UnknownVarFromCalendarArrowButton_Int_1 != 1 && UnknownVarFromCalendarArrowButton_Int_1 != 2)
         {
            UnknownVarFromCalendarArrowButton_Int_1 = 1;
         }
         updateWindow();
      }
      
      public function deactivate() : void
      {
         UnknownVarFromCalendarArrowButton_Int_1 = 0;
         updateWindow();
      }
      
      public function isInactive() : Boolean
      {
         return UnknownVarFromCalendarArrowButton_Int_1 == 0;
      }
      
      private function updateWindow() : void
      {
         switch(UnknownVarFromCalendarArrowButton_Int_1)
         {
            case 0:
               _window.bitmap = UnknownVarFromCalendarArrowButton_BitmapData_1;
               break;
            case 1:
               _window.bitmap = UnknownVarFromCalendarArrowButton_BitmapData_2;
               break;
            case 2:
               _window.bitmap = UnknownVarFromCalendarArrowButton_BitmapData_3;
         }
         if(_pressed)
         {
            _window.x = UnknownVarFromCalendarArrowButton_Point_1.x + PRESSED_OFFSET_PIXELS.x;
            _window.y = UnknownVarFromCalendarArrowButton_Point_1.y + PRESSED_OFFSET_PIXELS.y;
         }
         else
         {
            _window.position = UnknownVarFromCalendarArrowButton_Point_1;
         }
      }
      
      private function procedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1 as WindowMouseEvent != null)
         {
            switch(param1.type)
            {
               case "WME_OVER":
                  if(UnknownVarFromCalendarArrowButton_Int_1 != 0)
                  {
                     UnknownVarFromCalendarArrowButton_Int_1 = 2;
                  }
                  break;
               case "WME_OUT":
                  if(UnknownVarFromCalendarArrowButton_Int_1 != 0)
                  {
                     UnknownVarFromCalendarArrowButton_Int_1 = 1;
                  }
                  break;
               case "WME_DOWN":
                  _pressed = true;
                  break;
               case "WME_UP":
               case "WME_UP_OUTSIDE":
                  _pressed = false;
            }
            updateWindow();
            _callback(param1,param2);
         }
      }
   }
}

