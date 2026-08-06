package com.sulake.habbo.communication.messages.parser.preferences
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class AccountPreferencesParser implements IMessageParser
   {
      private var _traxVolume:int;
      
      private var _furniVolume:int;
      
      private var _uiVolume:int;
      
      private var _roomInvitesIgnored:Boolean;
      
      private var _roomCameraFollowDisabled:Boolean;
      
      private var _uiFlags:int;
      
      private var _preferedChatStyle:int;
      
      private var _wiredMenuButton:Boolean;
      
      private var _wiredInspectButton:Boolean;
      
      private var _playTestMode:Boolean;
      
      private var _wiredWhisperDisabled:Boolean;
      
      private var _showAllNotifications:Boolean;
      
      private var _wiredUiStyle:String;
      
      private var _chatSizePreference:int;
      
      private var _chatMode:int;
      
      private var _chatBubbleWidth:int;
      
      private var _chatScrollSpeed:int;
      
      public function AccountPreferencesParser()
      {
         super();
      }
      
      public function get traxVolume() : int
      {
         return _traxVolume;
      }
      
      public function get furniVolume() : int
      {
         return _furniVolume;
      }
      
      public function get uiVolume() : int
      {
         return _uiVolume;
      }
      
      public function get roomInvitesIgnored() : Boolean
      {
         return _roomInvitesIgnored;
      }
      
      public function get roomCameraFollowDisabled() : Boolean
      {
         return _roomCameraFollowDisabled;
      }
      
      public function get uiFlags() : int
      {
         return _uiFlags;
      }
      
      public function get preferedChatStyle() : int
      {
         return _preferedChatStyle;
      }
      
      public function get wiredMenuButton() : Boolean
      {
         return _wiredMenuButton;
      }
      
      public function get wiredInspectButton() : Boolean
      {
         return _wiredInspectButton;
      }
      
      public function get playTestMode() : Boolean
      {
         return _playTestMode;
      }
      
      public function get wiredWhisperDisabled() : Boolean
      {
         return _wiredWhisperDisabled;
      }
      
      public function get showAllNotifications() : Boolean
      {
         return _showAllNotifications;
      }
      
      public function get wiredUiStyle() : String
      {
         return _wiredUiStyle;
      }
      
      public function get chatSizePreference() : int
      {
         return _chatSizePreference;
      }
      
      public function get chatMode() : int
      {
         return _chatMode;
      }
      
      public function get chatBubbleWidth() : int
      {
         return _chatBubbleWidth;
      }
      
      public function get chatScrollSpeed() : int
      {
         return _chatScrollSpeed;
      }
      
      public function flush() : Boolean
      {
         _roomCameraFollowDisabled = false;
         _uiFlags = 0;
         _preferedChatStyle = 0;
         _wiredMenuButton = false;
         _wiredInspectButton = false;
         _playTestMode = false;
         _wiredWhisperDisabled = false;
         _showAllNotifications = false;
         _wiredUiStyle = "";
         _chatSizePreference = 0;
         _chatMode = 0;
         _chatBubbleWidth = 1;
         _chatScrollSpeed = 1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _uiVolume = param1.readInteger();
         _furniVolume = param1.readInteger();
         _traxVolume = param1.readInteger();
         param1.readBoolean();
         _roomInvitesIgnored = param1.readBoolean();
         _roomCameraFollowDisabled = param1.readBoolean();
         _uiFlags = param1.readInteger();
         _preferedChatStyle = param1.readInteger();
         _wiredMenuButton = param1.readBoolean();
         _wiredInspectButton = param1.readBoolean();
         _playTestMode = param1.readBoolean();
         param1.readInteger();
         _wiredWhisperDisabled = param1.readBoolean();
         if(param1.bytesAvailable > 0)
         {
            _showAllNotifications = param1.readBoolean();
         }
         if(param1.bytesAvailable > 0)
         {
            _wiredUiStyle = param1.readString();
         }
         else
         {
            _wiredUiStyle = "";
         }
         if(param1.bytesAvailable > 0)
         {
            _chatSizePreference = param1.readInteger();
         }
         else
         {
            _chatSizePreference = 0;
         }
         if(param1.bytesAvailable > 0)
         {
            _chatMode = param1.readInteger();
         }
         else
         {
            _chatMode = 0;
         }
         if(param1.bytesAvailable > 0)
         {
            _chatBubbleWidth = param1.readInteger();
         }
         else
         {
            _chatBubbleWidth = 1;
         }
         if(param1.bytesAvailable > 0)
         {
            _chatScrollSpeed = param1.readInteger();
         }
         else
         {
            _chatScrollSpeed = 1;
         }
         return true;
      }
   }
}

