package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ScrSendUserInfoMessageParser implements IMessageParser
   {
      public static const UnknownConstFromScrSendUserInfoMessageParser_Int_1:int = 1;
      
      public static const UnknownConstFromScrSendUserInfoMessageParser_Int_2:int = 2;
      
      public static const UnknownConstFromScrSendUserInfoMessageParser_Int_3:int = 3;
      
      public static const UnknownConstFromScrSendUserInfoMessageParser_Int_4:int = 4;
      
      private var _productName:String;
      
      private var _daysToPeriodEnd:int;
      
      private var _memberPeriods:int;
      
      private var _periodsSubscribedAhead:int;
      
      private var _responseType:int;
      
      private var _hasEverBeenMember:Boolean;
      
      private var _isVIP:Boolean;
      
      private var _pastClubDays:int;
      
      private var _pastVipDays:int;
      
      private var _minutesUntilExpiration:int;
      
      private var _minutesSinceLastModified:int;
      
      public function ScrSendUserInfoMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _productName = param1.readString();
         _daysToPeriodEnd = param1.readInteger();
         _memberPeriods = param1.readInteger();
         _periodsSubscribedAhead = param1.readInteger();
         _responseType = param1.readInteger();
         _hasEverBeenMember = param1.readBoolean();
         _isVIP = param1.readBoolean();
         _pastClubDays = param1.readInteger();
         _pastVipDays = param1.readInteger();
         _minutesUntilExpiration = param1.readInteger();
         if(param1.bytesAvailable)
         {
            _minutesSinceLastModified = param1.readInteger();
         }
         return true;
      }
      
      public function get productName() : String
      {
         return _productName;
      }
      
      public function get daysToPeriodEnd() : int
      {
         return _daysToPeriodEnd;
      }
      
      public function get memberPeriods() : int
      {
         return _memberPeriods;
      }
      
      public function get periodsSubscribedAhead() : int
      {
         return _periodsSubscribedAhead;
      }
      
      public function get responseType() : int
      {
         return _responseType;
      }
      
      public function get hasEverBeenMember() : Boolean
      {
         return _hasEverBeenMember;
      }
      
      public function get isVIP() : Boolean
      {
         return _isVIP;
      }
      
      public function get pastClubDays() : int
      {
         return _pastClubDays;
      }
      
      public function get pastVipDays() : int
      {
         return _pastVipDays;
      }
      
      public function get minutesUntilExpiration() : int
      {
         return _minutesUntilExpiration;
      }
      
      public function get minutesSinceLastModified() : int
      {
         return _minutesSinceLastModified;
      }
   }
}

