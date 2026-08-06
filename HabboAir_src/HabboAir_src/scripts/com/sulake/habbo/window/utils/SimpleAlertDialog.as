package com.sulake.habbo.window.utils
{
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextLinkWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   
   public class SimpleAlertDialog implements IComponentInterfaceQueue
   {
      private static const WINDOW_MARGIN:int = 10;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromSimpleAlertDialog_IModalDialog_1:IModalDialog;
      
      private var UnknownVarFromSimpleAlertDialog_String_1:String;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromSimpleAlertDialog_IItemListWindow_1:IItemListWindow;
      
      private var UnknownVarFromSimpleAlertDialog_IItemListWindow_2:IItemListWindow;
      
      private var UnknownVarFromSimpleAlertDialog_IItemListWindow_3:IItemListWindow;
      
      private var UnknownVarFromSimpleAlertDialog_IWindowModel_1:IWindowModel;
      
      private var UnknownVarFromSimpleAlertDialog_IWindowModel_2:IWindowModel;
      
      private var UnknownVarFromSimpleAlertDialog_ITextLinkWindow_1:ITextLinkWindow;
      
      private var UnknownVarFromSimpleAlertDialog_IStaticBitmapWrapperWindow_1:IStaticBitmapWrapperWindow;
      
      private var UnknownVarFromSimpleAlertDialog_Function_1:Function;
      
      private var UnknownVarFromSimpleAlertDialog_Function_2:Function;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      public function SimpleAlertDialog(param1:HabboWindowManagerComponent, param2:String, param3:String, param4:String, param5:String, param6:String, param7:Map, param8:String, param9:Function, param10:Function)
      {
         var _loc12_:String = null;
         super();
         UnknownVarFromSimpleAlertDialog_Function_1 = param9;
         UnknownVarFromSimpleAlertDialog_Function_2 = param10;
         _windowManager = param1;
         var _loc14_:ISoundAsset = param1.assets.getAssetByName("simple_alert_xml");
         UnknownVarFromSimpleAlertDialog_IModalDialog_1 = param1.buildModalDialogFromXML(_loc14_.content as XML);
         _window = IWindowController_1(UnknownVarFromSimpleAlertDialog_IModalDialog_1.rootWindow);
         UnknownVarFromSimpleAlertDialog_IItemListWindow_1 = IItemListWindow(_window.findChildByName("list"));
         UnknownVarFromSimpleAlertDialog_IItemListWindow_2 = IItemListWindow(_window.findChildByName("list_top"));
         UnknownVarFromSimpleAlertDialog_IItemListWindow_3 = IItemListWindow(_window.findChildByName("list_bottom"));
         UnknownVarFromSimpleAlertDialog_IWindowModel_1 = _window.findChildByName("message");
         UnknownVarFromSimpleAlertDialog_IWindowModel_2 = _window.findChildByName("subtitle");
         UnknownVarFromSimpleAlertDialog_ITextLinkWindow_1 = ITextLinkWindow(_window.findChildByName("link"));
         UnknownVarFromSimpleAlertDialog_IStaticBitmapWrapperWindow_1 = IStaticBitmapWrapperWindow(_window.findChildByName("illustration"));
         _window.findChildByName("header_button_close").dispose();
         _window.procedure = windowProcedure;
         _window.caption = param2;
         UnknownVarFromSimpleAlertDialog_IWindowModel_1.caption = param4;
         if(param7 != null)
         {
            for each(var _loc13_ in [param2,param3,param4,param5])
            {
               if(_loc13_ != null && _loc13_.substr(0,2) == "${" && _loc13_.indexOf("}") > 0)
               {
                  _loc12_ = _loc13_.substring(2,_loc13_.indexOf("}"));
                  for(var _loc11_ in param7)
                  {
                     param1.localization.registerParameter(_loc12_,_loc11_,param7.getValue(_loc11_));
                  }
               }
            }
         }
         if(param3 != null && param3 != "")
         {
            UnknownVarFromSimpleAlertDialog_IWindowModel_2.caption = param3;
         }
         else
         {
            UnknownVarFromSimpleAlertDialog_IWindowModel_2.dispose();
            UnknownVarFromSimpleAlertDialog_IWindowModel_2 = null;
         }
         param6 = param1.interpolate(param6);
         if(param5 != null && param5 != "" && (param6 != null && param6 != "" || param9 != null))
         {
            UnknownVarFromSimpleAlertDialog_ITextLinkWindow_1.caption = param5;
            UnknownVarFromSimpleAlertDialog_ITextLinkWindow_1.addEventListener("WME_CLICK",onSimpleAlertClick);
            UnknownVarFromSimpleAlertDialog_ITextLinkWindow_1.immediateClickMode = true;
            UnknownVarFromSimpleAlertDialog_String_1 = param6;
         }
         else
         {
            UnknownVarFromSimpleAlertDialog_ITextLinkWindow_1.dispose();
            UnknownVarFromSimpleAlertDialog_ITextLinkWindow_1 = null;
         }
         if(param8 != null && param8 != "")
         {
            UnknownVarFromSimpleAlertDialog_IStaticBitmapWrapperWindow_1.addEventListener("WE_RESIZED",onIllustrationResized);
            UnknownVarFromSimpleAlertDialog_IStaticBitmapWrapperWindow_1.assetUri = param8;
         }
         else
         {
            UnknownVarFromSimpleAlertDialog_IStaticBitmapWrapperWindow_1.dispose();
            UnknownVarFromSimpleAlertDialog_IStaticBitmapWrapperWindow_1 = null;
         }
         resizeWindow();
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            close();
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function close() : void
      {
         if(UnknownVarFromSimpleAlertDialog_Function_2 != null)
         {
            UnknownVarFromSimpleAlertDialog_Function_2();
         }
         if(UnknownVarFromSimpleAlertDialog_IModalDialog_1 != null)
         {
            if(UnknownVarFromSimpleAlertDialog_ITextLinkWindow_1 != null)
            {
               UnknownVarFromSimpleAlertDialog_ITextLinkWindow_1.removeEventListener("WME_CLICK",onSimpleAlertClick);
               UnknownVarFromSimpleAlertDialog_ITextLinkWindow_1 = null;
            }
            if(UnknownVarFromSimpleAlertDialog_IStaticBitmapWrapperWindow_1)
            {
               UnknownVarFromSimpleAlertDialog_IStaticBitmapWrapperWindow_1.removeEventListener("WE_RESIZED",onIllustrationResized);
               UnknownVarFromSimpleAlertDialog_IStaticBitmapWrapperWindow_1 = null;
            }
            _window = null;
            UnknownVarFromSimpleAlertDialog_IItemListWindow_1 = null;
            UnknownVarFromSimpleAlertDialog_IItemListWindow_2 = null;
            UnknownVarFromSimpleAlertDialog_IItemListWindow_3 = null;
            UnknownVarFromSimpleAlertDialog_IWindowModel_1 = null;
            UnknownVarFromSimpleAlertDialog_IWindowModel_2 = null;
            UnknownVarFromSimpleAlertDialog_Function_1 = null;
            UnknownVarFromSimpleAlertDialog_Function_2 = null;
            UnknownVarFromSimpleAlertDialog_IModalDialog_1.dispose();
            UnknownVarFromSimpleAlertDialog_IModalDialog_1 = null;
         }
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK" && param2.name == "close_button")
         {
            dispose();
         }
      }
      
      private function onSimpleAlertClick(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromSimpleAlertDialog_String_1 != null && UnknownVarFromSimpleAlertDialog_String_1.length > 0)
         {
            if(UnknownVarFromSimpleAlertDialog_String_1.substr(0,6) == "event:")
            {
               _windowManager.context.createLinkEvent(UnknownVarFromSimpleAlertDialog_String_1.substr(6));
               dispose();
            }
            else
            {
               HabboWebTools.openWebPage(UnknownVarFromSimpleAlertDialog_String_1,"habboMain");
            }
         }
         else if(UnknownVarFromSimpleAlertDialog_Function_1 != null)
         {
            UnknownVarFromSimpleAlertDialog_Function_1();
            dispose();
         }
      }
      
      private function onIllustrationResized(param1:WindowEvent) : void
      {
         UnknownVarFromSimpleAlertDialog_IItemListWindow_2.x = UnknownVarFromSimpleAlertDialog_IStaticBitmapWrapperWindow_1.width + 10;
         UnknownVarFromSimpleAlertDialog_IItemListWindow_3.width = UnknownVarFromSimpleAlertDialog_IItemListWindow_2.right;
         _window.width = UnknownVarFromSimpleAlertDialog_IItemListWindow_2.right + 2 * 10;
         UnknownVarFromSimpleAlertDialog_IItemListWindow_2.limits.minHeight = UnknownVarFromSimpleAlertDialog_IStaticBitmapWrapperWindow_1.height + 10;
         resizeWindow();
      }
      
      private function resizeWindow() : void
      {
         UnknownVarFromSimpleAlertDialog_IItemListWindow_2.arrangeListItems();
         UnknownVarFromSimpleAlertDialog_IItemListWindow_3.arrangeListItems();
         UnknownVarFromSimpleAlertDialog_IItemListWindow_1.arrangeListItems();
         _window.height = UnknownVarFromSimpleAlertDialog_IItemListWindow_1.height + 40;
         _window.center();
      }
   }
}

