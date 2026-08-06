package com.sulake.core.window.utils
{
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   import flash.utils.Dictionary;
   
   public class MouseCursorControl
   {
      private static var _type:uint = 0;
      
      private static var UnknownVarFromMouseCursorControl_Stage_1:Stage;
      
      private static var _visible:Boolean = true;
      
      private static var _disposed:Boolean = false;
      
      private static var UnknownVarFromMouseCursorControl_Boolean_1:Boolean = true;
      
      private static var UnknownVarFromMouseCursorControl_DisplayObject_1:DisplayObject;
      
      private static var UnknownVarFromMouseCursorControl_Dictionary_1:Dictionary = new Dictionary();
      
      public function MouseCursorControl(param1:DisplayObject)
      {
         super();
         UnknownVarFromMouseCursorControl_Stage_1 = param1.stage;
      }
      
      public static function dispose() : void
      {
         if(!_disposed)
         {
            if(UnknownVarFromMouseCursorControl_DisplayObject_1)
            {
               UnknownVarFromMouseCursorControl_Stage_1.removeChild(UnknownVarFromMouseCursorControl_DisplayObject_1);
               UnknownVarFromMouseCursorControl_Stage_1.removeEventListener("mouseLeave",onStageMouseLeave);
               UnknownVarFromMouseCursorControl_Stage_1.removeEventListener("mouseMove",onStageMouseMove);
               UnknownVarFromMouseCursorControl_Stage_1.removeEventListener("mouseOver",onStageMouseMove);
               UnknownVarFromMouseCursorControl_Stage_1.removeEventListener("mouseOut",onStageMouseMove);
            }
            _disposed = true;
         }
      }
      
      public static function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public static function get type() : uint
      {
         return _type;
      }
      
      public static function set type(param1:uint) : void
      {
         if(_type != param1)
         {
            _type = param1;
            UnknownVarFromMouseCursorControl_Boolean_1 = true;
         }
      }
      
      public static function get visible() : Boolean
      {
         return _visible;
      }
      
      public static function set visible(param1:Boolean) : void
      {
         _visible = param1;
         if(_visible)
         {
            if(UnknownVarFromMouseCursorControl_DisplayObject_1)
            {
               UnknownVarFromMouseCursorControl_DisplayObject_1.visible = true;
            }
            else
            {
               Mouse.show();
            }
         }
         else if(UnknownVarFromMouseCursorControl_DisplayObject_1)
         {
            UnknownVarFromMouseCursorControl_DisplayObject_1.visible = false;
         }
         else
         {
            Mouse.hide();
         }
      }
      
      public static function change() : void
      {
         var _loc1_:DisplayObject = null;
         if(UnknownVarFromMouseCursorControl_Boolean_1)
         {
            _loc1_ = UnknownVarFromMouseCursorControl_Dictionary_1[_type];
            if(_loc1_)
            {
               if(UnknownVarFromMouseCursorControl_DisplayObject_1)
               {
                  UnknownVarFromMouseCursorControl_Stage_1.removeChild(UnknownVarFromMouseCursorControl_DisplayObject_1);
               }
               else
               {
                  UnknownVarFromMouseCursorControl_Stage_1.addEventListener("mouseLeave",onStageMouseLeave);
                  UnknownVarFromMouseCursorControl_Stage_1.addEventListener("mouseMove",onStageMouseMove);
                  UnknownVarFromMouseCursorControl_Stage_1.addEventListener("mouseOver",onStageMouseMove);
                  UnknownVarFromMouseCursorControl_Stage_1.addEventListener("mouseOut",onStageMouseMove);
                  Mouse.hide();
               }
               UnknownVarFromMouseCursorControl_DisplayObject_1 = _loc1_;
               UnknownVarFromMouseCursorControl_Stage_1.addChild(UnknownVarFromMouseCursorControl_DisplayObject_1);
            }
            else
            {
               if(UnknownVarFromMouseCursorControl_DisplayObject_1)
               {
                  UnknownVarFromMouseCursorControl_Stage_1.removeChild(UnknownVarFromMouseCursorControl_DisplayObject_1);
                  UnknownVarFromMouseCursorControl_Stage_1.removeEventListener("mouseLeave",onStageMouseLeave);
                  UnknownVarFromMouseCursorControl_Stage_1.removeEventListener("mouseMove",onStageMouseMove);
                  UnknownVarFromMouseCursorControl_Stage_1.removeEventListener("mouseOver",onStageMouseMove);
                  UnknownVarFromMouseCursorControl_Stage_1.removeEventListener("mouseOut",onStageMouseMove);
                  UnknownVarFromMouseCursorControl_DisplayObject_1 = null;
                  Mouse.show();
               }
               switch(_type)
               {
                  case 0:
                  case 1:
                     Mouse.cursor = "auto";
                     break;
                  case 2:
                     Mouse.cursor = "button";
                     break;
                  case 5:
                  case 6:
                  case 7:
                  case 8:
                     Mouse.cursor = "hand";
                     break;
                  case 14:
                     Mouse.cursor = "ibeam";
                     break;
                  case 4294967294:
                     Mouse.cursor = "auto";
                     Mouse.hide();
               }
            }
            UnknownVarFromMouseCursorControl_Boolean_1 = false;
         }
      }
      
      public static function defineCustomCursorType(param1:uint, param2:DisplayObject) : void
      {
         UnknownVarFromMouseCursorControl_Dictionary_1[param1] = param2;
      }
      
      private static function onStageMouseMove(param1:MouseEvent) : void
      {
         if(UnknownVarFromMouseCursorControl_DisplayObject_1)
         {
            UnknownVarFromMouseCursorControl_DisplayObject_1.x = param1.stageX - 2;
            UnknownVarFromMouseCursorControl_DisplayObject_1.y = param1.stageY;
            if(_type == 0)
            {
               _visible = false;
               Mouse.show();
            }
            else
            {
               _visible = true;
               Mouse.hide();
            }
         }
      }
      
      private static function onStageMouseLeave(param1:Event) : void
      {
         if(UnknownVarFromMouseCursorControl_DisplayObject_1 && _type != 0)
         {
            Mouse.hide();
            _visible = false;
         }
      }
   }
}

