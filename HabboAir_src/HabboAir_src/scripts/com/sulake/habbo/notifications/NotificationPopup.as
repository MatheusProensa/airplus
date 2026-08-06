package com.sulake.habbo.notifications
{
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.utils.IModalDialog;
   
   public class NotificationPopup implements IComponentInterfaceQueue
   {
      private var _notifications:HabboNotifications;
      
      private var UnknownVarFromNotificationPopup_IModalDialog_1:IModalDialog;
      
      private var UnknownVarFromNotificationPopup_String_1:String;
      
      private var _parameters:Map;
      
      public function NotificationPopup(param1:HabboNotifications, param2:String, param3:Map)
      {
         var _loc7_:IWindowModel = null;
         var _loc8_:IWindowModel = null;
         super();
         _notifications = param1;
         UnknownVarFromNotificationPopup_String_1 = param2;
         _parameters = param3;
         var _loc10_:String = getNotificationPart("title",true);
         var _loc11_:String = getNotificationPart("message",true).replace(/\\r/g,"\r");
         var _loc6_:String = getNotificationPart("linkUrl",false);
         var _loc4_:* = null;
         var _loc5_:Boolean = _loc6_ != null && _loc6_.substr(0,6) == "event:";
         if(_loc6_ != null)
         {
            _loc4_ = getNotificationPart("linkTitle",false);
            if(_loc4_ == null)
            {
               _loc4_ = _loc6_;
            }
         }
         var _loc12_:ISoundAsset = _notifications.assets.getAssetByName("layout_notification_popup_xml");
         UnknownVarFromNotificationPopup_IModalDialog_1 = _notifications.windowManager.buildModalDialogFromXML(_loc12_.content as XML);
         var _loc9_:IWindowController_1 = UnknownVarFromNotificationPopup_IModalDialog_1.rootWindow as IWindowController_1;
         _loc9_.procedure = windowProcedure;
         _loc9_.caption = _loc10_;
         if(_loc6_ != null)
         {
            if(_loc5_)
            {
               _loc7_ = _loc9_.findChildByName("action");
               _loc7_.visible = true;
               _loc7_.caption = _loc4_;
            }
            else
            {
               _loc8_ = _loc9_.findChildByName("link");
               _loc8_.visible = true;
               _loc8_.caption = _loc4_;
            }
         }
         _loc9_.findChildByName("message").caption = _loc11_;
         IStaticBitmapWrapperWindow(_loc9_.findChildByName("illustration")).assetUri = _notifications.getNotificationImageUrl(param3,param2);
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         UnknownVarFromNotificationPopup_IModalDialog_1.dispose();
         UnknownVarFromNotificationPopup_IModalDialog_1 = null;
         _notifications = null;
         UnknownVarFromNotificationPopup_String_1 = null;
         _parameters = null;
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromNotificationPopup_IModalDialog_1 == null;
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(disposed)
         {
            return;
         }
         switch(param1.type)
         {
            case "WME_CLICK":
               switch(param2.name)
               {
                  case "header_button_close":
                     dispose();
                     break;
                  case "action":
                     _notifications.createLinkEvent(getNotificationPart("linkUrl",false).substr(6));
                     dispose();
                     break;
                  case "link":
                     HabboWebTools.openWebPage(getNotificationPart("linkUrl",false),"habboMain");
               }
               break;
            case "WE_RESIZED":
               if(param2.name == "illustration")
               {
                  param2.parent.limits.minHeight = param2.height;
               }
         }
      }
      
      private function getNotificationPart(param1:String, param2:Boolean) : String
      {
         return _notifications.getNotificationPart(_parameters,UnknownVarFromNotificationPopup_String_1,param1,param2);
      }
   }
}

