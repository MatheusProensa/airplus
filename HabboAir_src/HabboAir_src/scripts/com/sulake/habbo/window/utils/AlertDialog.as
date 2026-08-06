package com.sulake.habbo.window.utils
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IInteractiveWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.IMouseCursorControl;
   import com.sulake.core.window.utils.INotify;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public class AlertDialog implements UnknownICoreWindowUtils1, INotify
   {
      protected static const LIST_BUTTONS:String = "_alert_button_list";
      
      protected static const UnknownConstFromAlertDialog_String_1:String = "_alert_button_ok";
      
      protected static const UnknownConstFromAlertDialog_String_2:String = "_alert_button_cancel";
      
      protected static const BUTTON_CUSTOM:String = "_alert_button_custom";
      
      protected static const UnknownConstFromAlertDialog_String_3:String = "header_button_close";
      
      protected static const UnknownConstFromAlertDialog_String_4:String = "_alert_text_summary";
      
      private static var UnknownVarFromAlertDialog_Uint_1:uint = 0;
      
      protected var _title:String = "";
      
      protected var _summary:String = "";
      
      protected var _disposed:Boolean = false;
      
      protected var _callback:Function = null;
      
      protected var _window:IFrameController;
      
      protected var UnknownVarFromAlertDialog_IModalDialog_1:IModalDialog;
      
      public function AlertDialog(param1:IHabboWindowManagerComponent, param2:XML, param3:String, param4:String, param5:uint, param6:Function, param7:Boolean)
      {
         var _loc8_:IWindowModel = null;
         super();
         UnknownVarFromAlertDialog_Uint_1++;
         if(param7)
         {
            UnknownVarFromAlertDialog_IModalDialog_1 = param1.buildModalDialogFromXML(param2);
            _window = UnknownVarFromAlertDialog_IModalDialog_1.rootWindow as IFrameController;
         }
         else
         {
            _window = param1.buildFromXML(param2,2) as IFrameController;
         }
         if(param5 == 0)
         {
            param5 = uint(0x10 | 1 | 2);
         }
         var _loc9_:IItemListWindow = _window.findChildByName("_alert_button_list") as IItemListWindow;
         if(_loc9_)
         {
            if(!(param5 & 0x10))
            {
               _loc8_ = _loc9_.getListItemByName("_alert_button_ok");
               _loc8_.dispose();
            }
            if(!(param5 & 0x20))
            {
               _loc8_ = _loc9_.getListItemByName("_alert_button_cancel");
               _loc8_.dispose();
            }
            if(!(param5 & 0x40))
            {
               _loc8_ = _loc9_.getListItemByName("_alert_button_custom");
               _loc8_.dispose();
            }
         }
         _window.procedure = dialogEventProc;
         _window.center();
         this.title = param3;
         this.summary = param4;
         this.callback = param6;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(UnknownVarFromAlertDialog_IModalDialog_1 && !UnknownVarFromAlertDialog_IModalDialog_1.disposed)
            {
               UnknownVarFromAlertDialog_IModalDialog_1.dispose();
               UnknownVarFromAlertDialog_IModalDialog_1 = null;
               _window = null;
            }
            if(_window && !_window.disposed)
            {
               _window.dispose();
               _window = null;
            }
            _callback = null;
            _disposed = true;
         }
      }
      
      protected function dialogEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:WindowEvent = null;
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "_alert_button_ok":
                  if(_callback != null)
                  {
                     _loc3_ = WindowEvent.allocate("WE_OK",null,null);
                     _callback(this,_loc3_);
                     _loc3_.recycle();
                  }
                  else
                  {
                     dispose();
                  }
                  break;
               case "header_button_close":
               case "_alert_button_cancel":
                  if(_callback != null)
                  {
                     _loc3_ = WindowEvent.allocate("WE_CANCEL",null,null);
                     _callback(this,_loc3_);
                     _loc3_.recycle();
                  }
                  else
                  {
                     dispose();
                  }
            }
         }
      }
      
      public function getButtonCaption(param1:int) : IMouseCursorControl
      {
         var _loc2_:IInteractiveWindow = null;
         if(!_disposed)
         {
            switch(param1)
            {
               case 16:
                  _loc2_ = _window.findChildByName("_alert_button_ok") as IInteractiveWindow;
                  break;
               case 32:
                  _loc2_ = _window.findChildByName("_alert_button_cancel") as IInteractiveWindow;
                  break;
               case 64:
                  _loc2_ = _window.findChildByName("_alert_button_custom") as IInteractiveWindow;
            }
         }
         return !!_loc2_ ? new AlertDialogCaption(_loc2_.caption,_loc2_.toolTipCaption,_loc2_.visible) : null;
      }
      
      public function setButtonCaption(param1:int, param2:IMouseCursorControl) : void
      {
         var _loc3_:IInteractiveWindow = null;
         if(!_disposed)
         {
            switch(param1)
            {
               case 16:
                  _loc3_ = _window.findChildByName("_alert_button_ok") as IInteractiveWindow;
                  break;
               case 32:
                  _loc3_ = _window.findChildByName("_alert_button_cancel") as IInteractiveWindow;
                  break;
               case 64:
                  _loc3_ = _window.findChildByName("_alert_button_custom") as IInteractiveWindow;
            }
         }
         if(_loc3_)
         {
            _loc3_.caption = param2.text;
         }
      }
      
      public function set title(param1:String) : void
      {
         _title = param1;
         if(_window)
         {
            _window.caption = _title;
         }
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function set summary(param1:String) : void
      {
         _summary = param1;
         if(_window)
         {
            ITextWindow(_window.findChildByTag("DESCRIPTION")).text = _summary;
         }
      }
      
      public function get summary() : String
      {
         return _summary;
      }
      
      public function set titleBarColor(param1:uint) : void
      {
         if(!_window)
         {
            return;
         }
         _window.color = param1;
      }
      
      public function get titleBarColor() : uint
      {
         if(!_window)
         {
            return 0;
         }
         return _window.color;
      }
      
      public function set callback(param1:Function) : void
      {
         _callback = param1;
      }
      
      public function get callback() : Function
      {
         return _callback;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

