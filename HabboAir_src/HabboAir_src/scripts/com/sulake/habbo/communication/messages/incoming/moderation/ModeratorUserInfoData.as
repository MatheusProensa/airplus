package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class ModeratorUserInfoData
   {
      private var _userId:int;
      
      private var _userName:String;
      
      private var _registrationAgeInMinutes:int;
      
      private var _minutesSinceLastLogin:int;
      
      private var _online:Boolean;
      
      private var _cfhCount:int;
      
      private var _abusiveCfhCount:int;
      
      private var _cautionCount:int;
      
      private var _banCount:int;
      
      private var _tradingLockCount:int;
      
      private var _tradingExpiryDate:String;
      
      private var _lastPurchaseDate:String;
      
      private var _identityId:int;
      
      private var _identityRelatedBanCount:int;
      
      private var _primaryEmailAddress:String;
      
      private var _figure:String;
      
      private var _userClassification:String;
      
      private var _lastSanctionTime:String = "";
      
      private var _sanctionAgeHours:int = 0;
      
      public function ModeratorUserInfoData(param1:IMessageDataWrapper)
      {
         super();
         _userId = param1.readInteger();
         _userName = param1.readString();
         _figure = param1.readString();
         _registrationAgeInMinutes = param1.readInteger();
         _minutesSinceLastLogin = param1.readInteger();
         _online = param1.readBoolean();
         _cfhCount = param1.readInteger();
         _abusiveCfhCount = param1.readInteger();
         _cautionCount = param1.readInteger();
         _banCount = param1.readInteger();
         _tradingLockCount = param1.readInteger();
         _tradingExpiryDate = param1.readString();
         _lastPurchaseDate = param1.readString();
         _identityId = param1.readInteger();
         _identityRelatedBanCount = param1.readInteger();
         _primaryEmailAddress = param1.readString();
         _userClassification = param1.readString();
         if(param1.bytesAvailable)
         {
            _lastSanctionTime = param1.readString();
            _sanctionAgeHours = param1.readInteger();
         }
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get figure() : String
      {
         return _figure;
      }
      
      public function get registrationAgeInMinutes() : int
      {
         return _registrationAgeInMinutes;
      }
      
      public function get minutesSinceLastLogin() : int
      {
         return _minutesSinceLastLogin;
      }
      
      public function get online() : Boolean
      {
         return _online;
      }
      
      public function get cfhCount() : int
      {
         return _cfhCount;
      }
      
      public function get abusiveCfhCount() : int
      {
         return _abusiveCfhCount;
      }
      
      public function get cautionCount() : int
      {
         return _cautionCount;
      }
      
      public function get banCount() : int
      {
         return _banCount;
      }
      
      public function get tradingLockCount() : int
      {
         return _tradingLockCount;
      }
      
      public function get tradingExpiryDate() : String
      {
         return _tradingExpiryDate;
      }
      
      public function get lastPurchaseDate() : String
      {
         return _lastPurchaseDate;
      }
      
      public function get identityId() : int
      {
         return _identityId;
      }
      
      public function get identityRelatedBanCount() : int
      {
         return _identityRelatedBanCount;
      }
      
      public function get primaryEmailAddress() : String
      {
         return _primaryEmailAddress;
      }
      
      public function get userClassification() : String
      {
         return _userClassification;
      }
      
      public function get lastSanctionTime() : String
      {
         return _lastSanctionTime;
      }
      
      public function get sanctionAgeHours() : int
      {
         return _sanctionAgeHours;
      }
   }
}

