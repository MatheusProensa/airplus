package com.sulake.habbo.moderation
{
   import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorUserInfoData;
   
   public interface IUserInfoCtrl
   {
      function onUserInfo(param1:ModeratorUserInfoData) : void;
   }
}

