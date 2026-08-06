package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.events.WindowEvent;
   import flash.geom.Rectangle;
   
   public class CheckBoxController extends SelectableController implements UnknownICoreWindowComponents2
   {
      protected static const TEXT_FIELD_NAME:String = "_CAPTION_TEXT";
      
      public function CheckBoxController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindowModel, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      override public function set caption(param1:String) : void
      {
         super.caption = param1;
         var _loc2_:IWindowModel = getChildByName("_CAPTION_TEXT");
         if(_loc2_ != null)
         {
            _loc2_.caption = caption;
         }
      }
      
      override public function update(param1:WindowController, param2:WindowEvent) : Boolean
      {
         if(param1 == this)
         {
            switch(param2.type)
            {
               case "WME_DOWN":
                  if(isSelected)
                  {
                     param2.preventWindowOperation();
                  }
                  break;
               case "WME_UP":
                  if(isSelected)
                  {
                     unselect();
                  }
                  else
                  {
                     select();
                  }
            }
         }
         return super.update(param1,param2);
      }
   }
}

