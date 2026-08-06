package com.sulake.habbo.friendbar.view.tabs.tokens
{
   import com.sulake.habbo.friendbar.data.IFriendEntity;
   import com.sulake.habbo.friendbar.data.IFriendNotification;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   
   public class AchievementToken extends Token
   {
      public function AchievementToken(param1:IFriendEntity, param2:IFriendNotification, param3:IHabboLocalizationManager)
      {
         super(param2);
         var _loc4_:String = param3.getBadgeName(param2.message);
         prepare("${friendbar.notify.achievement}",_loc4_,"message_piece_xml","friend_bar_event_notification_icon");
      }
   }
}

