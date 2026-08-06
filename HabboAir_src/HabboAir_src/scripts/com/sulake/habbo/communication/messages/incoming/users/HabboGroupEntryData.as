package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class HabboGroupEntryData
   {
      private var _groupId:int;
      
      private var _groupName:String;
      
      private var _badgeCode:String;
      
      private var _primaryColor:String;
      
      private var _secondaryColor:String;
      
      private var _favourite:Boolean;
      
      private var _ownerId:int;
      
      private var _hasForum:Boolean;
      
      public function HabboGroupEntryData(param1:IMessageDataWrapper)
      {
         super();
         _groupId = param1.readInteger();
         _groupName = param1.readString();
         _badgeCode = param1.readString();
         _primaryColor = param1.readString();
         _secondaryColor = param1.readString();
         _favourite = param1.readBoolean();
         _ownerId = param1.readInteger();
         _hasForum = param1.readBoolean();
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function get groupName() : String
      {
         return _groupName;
      }
      
      public function get badgeCode() : String
      {
         return _badgeCode;
      }
      
      public function get primaryColor() : String
      {
         return _primaryColor;
      }
      
      public function get secondaryColor() : String
      {
         return _secondaryColor;
      }
      
      public function get favourite() : Boolean
      {
         return _favourite;
      }
      
      public function get ownerId() : int
      {
         return _ownerId;
      }
      
      public function get hasForum() : Boolean
      {
         return _hasForum;
      }
   }
}

