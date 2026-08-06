package com.sulake.habbo.toolbar.extensions.settings
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.UnknownICoreWindowComponents2;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.outgoing.gifts.ResetPhoneNumberStateMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.preferences.SetIgnoreRoomInvitesMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.preferences.SetRoomCameraPreferencesMessageComposer;
   import com.sulake.habbo.toolbar.HabboToolbar;
   
   public class OtherSettingsView
   {
      private var _window:IWindowController_1;
      
      private var _toolbar:HabboToolbar;
      
      public function OtherSettingsView(param1:HabboToolbar)
      {
         super();
         _toolbar = param1;
         createWindow();
      }
      
      public function dispose() : void
      {
         if(_window == null)
         {
            return;
         }
         _window.dispose();
         _window = null;
      }
      
      private function createWindow() : void
      {
         var _loc3_:XmlAsset = _toolbar.assets.getAssetByName("me_menu_other_settings_xml") as XmlAsset;
         _window = _toolbar.windowManager.buildFromXML(_loc3_.content as XML) as IWindowController_1;
         _window.procedure = onButtonClicked;
         UnknownICoreWindowComponents2(_window.findChildByName("ignore_room_invites_checkbox")).isSelected = _toolbar.messenger.getRoomInvitesIgnored();
         UnknownICoreWindowComponents2(_window.findChildByName("disable_wired_whisper_checkbox")).isSelected = _toolbar.roomEvents.wiredWhisperDisabled;
         _window.findChildByName("disable_room_camera_follow").visible = _toolbar.getBoolean("room.camera.follow_user");
         if(_toolbar.getBoolean("room.camera.follow_user"))
         {
            UnknownICoreWindowComponents2(_window.findChildByName("disable_room_camera_follow_checkbox")).isSelected = _toolbar.sessionDataManager.isRoomCameraFollowDisabled;
         }
         var _loc1_:Boolean = _toolbar.getBoolean("sms.identity.verification.enabled");
         var _loc5_:* = _toolbar.getInteger("phone.verification.status",0) == 2;
         var _loc2_:* = _toolbar.getInteger("phone.collection.status",0) == 2;
         var _loc6_:Boolean = _toolbar.getBoolean("sms.identity.verification.button.enabled");
         var _loc4_:* = _toolbar.getInteger("phone.collection.status",0) == 0;
         var _loc7_:Boolean = _loc1_ && !_loc5_ && (_loc2_ || _loc6_ && _loc4_);
         _window.findChildByName("btn_reset_phone_number_collection").visible = _loc7_;
      }
      
      private function onButtonClicked(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc5_:Boolean = false;
         var _loc4_:Boolean = false;
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var _loc3_:String = param2.name;
         switch(_loc3_)
         {
            case "back_btn":
               dispose();
               break;
            case "ignore_room_invites_checkbox":
               _toolbar.messenger.setRoomInvitesIgnored(UnknownICoreWindowComponents2(_window.findChildByName("ignore_room_invites_checkbox")).isSelected);
               _toolbar.connection.send(new SetIgnoreRoomInvitesMessageComposer(_toolbar.messenger.getRoomInvitesIgnored()));
               break;
            case "disable_wired_whisper_checkbox":
               _loc5_ = Boolean(UnknownICoreWindowComponents2(_window.findChildByName("disable_wired_whisper_checkbox")).isSelected);
               _toolbar.roomEvents.wiredWhisperDisabled = _loc5_;
               break;
            case "disable_room_camera_follow_checkbox":
               _loc4_ = Boolean(UnknownICoreWindowComponents2(_window.findChildByName("disable_room_camera_follow_checkbox")).isSelected);
               _toolbar.connection.send(new SetRoomCameraPreferencesMessageComposer(_loc4_));
               _toolbar.sessionDataManager.setRoomCameraFollowDisabled(_loc4_);
               break;
            case "btn_reset_phone_number_collection":
               _window.findChildByName("btn_reset_phone_number_collection").visible = false;
               _toolbar.connection.send(new ResetPhoneNumberStateMessageComposer());
         }
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
   }
}

