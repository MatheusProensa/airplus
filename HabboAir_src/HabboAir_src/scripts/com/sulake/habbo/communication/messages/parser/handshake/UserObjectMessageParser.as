package com.sulake.habbo.communication.messages.parser.handshake
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UserObjectMessageParser implements IMessageParser
   {
      private var UnknownVarFromUserObjectMessageParser_Int_1:int;
      
      private var _name:String;
      
      private var UnknownVarFromUserObjectMessageParser_String_1:String;
      
      private var UnknownVarFromUserObjectMessageParser_String_2:String;
      
      private var UnknownVarFromUserObjectMessageParser_String_3:String;
      
      private var _realName:String;
      
      private var UnknownVarFromUserObjectMessageParser_Boolean_1:Boolean;
      
      private var UnknownVarFromUserObjectMessageParser_Int_2:int;
      
      private var UnknownVarFromUserObjectMessageParser_Int_3:int;
      
      private var UnknownVarFromUserObjectMessageParser_Int_4:int;
      
      private var UnknownVarFromUserObjectMessageParser_Boolean_2:Boolean;
      
      private var UnknownVarFromUserObjectMessageParser_String_4:String;
      
      private var UnknownVarFromUserObjectMessageParser_Boolean_3:Boolean;
      
      private var _accountSafetyLocked:Boolean = false;
      
      private var _accountTradeLocked:Boolean = false;
      
      private var _nameColor:String = "";
      
      private var _respectReplenishesLeft:int = 0;
      
      private var _maxRespectPerDay:int = 3;
      
      public function UserObjectMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.UnknownVarFromUserObjectMessageParser_Int_1 = param1.readInteger();
         this._name = param1.readString();
         this.UnknownVarFromUserObjectMessageParser_String_1 = param1.readString();
         this.UnknownVarFromUserObjectMessageParser_String_2 = param1.readString();
         this.UnknownVarFromUserObjectMessageParser_String_3 = param1.readString();
         this._realName = param1.readString();
         this.UnknownVarFromUserObjectMessageParser_Boolean_1 = param1.readBoolean();
         this.UnknownVarFromUserObjectMessageParser_Int_2 = param1.readInteger();
         this.UnknownVarFromUserObjectMessageParser_Int_3 = param1.readInteger();
         this.UnknownVarFromUserObjectMessageParser_Int_4 = param1.readInteger();
         this.UnknownVarFromUserObjectMessageParser_Boolean_2 = param1.readBoolean();
         this.UnknownVarFromUserObjectMessageParser_String_4 = param1.readString();
         this.UnknownVarFromUserObjectMessageParser_Boolean_3 = param1.readBoolean();
         this._accountSafetyLocked = param1.readBoolean();
         if(param1.bytesAvailable > 0)
         {
            _accountTradeLocked = param1.readBoolean();
            _nameColor = param1.readString();
         }
         if(param1.bytesAvailable > 0)
         {
            _respectReplenishesLeft = param1.readInteger();
            _maxRespectPerDay = param1.readInteger();
         }
         return true;
      }
      
      public function get id() : int
      {
         return this.UnknownVarFromUserObjectMessageParser_Int_1;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get figure() : String
      {
         return this.UnknownVarFromUserObjectMessageParser_String_1;
      }
      
      public function get sex() : String
      {
         return this.UnknownVarFromUserObjectMessageParser_String_2;
      }
      
      public function get customData() : String
      {
         return this.UnknownVarFromUserObjectMessageParser_String_3;
      }
      
      public function get realName() : String
      {
         return this._realName;
      }
      
      public function get directMail() : Boolean
      {
         return this.UnknownVarFromUserObjectMessageParser_Boolean_1;
      }
      
      public function get respectTotal() : int
      {
         return this.UnknownVarFromUserObjectMessageParser_Int_2;
      }
      
      public function get respectLeft() : int
      {
         return this.UnknownVarFromUserObjectMessageParser_Int_3;
      }
      
      public function get petRespectLeft() : int
      {
         return this.UnknownVarFromUserObjectMessageParser_Int_4;
      }
      
      public function get streamPublishingAllowed() : Boolean
      {
         return this.UnknownVarFromUserObjectMessageParser_Boolean_2;
      }
      
      public function get lastAccessDate() : String
      {
         return this.UnknownVarFromUserObjectMessageParser_String_4;
      }
      
      public function get nameChangeAllowed() : Boolean
      {
         return this.UnknownVarFromUserObjectMessageParser_Boolean_3;
      }
      
      public function get accountSafetyLocked() : Boolean
      {
         return _accountSafetyLocked;
      }
      
      public function get accountTradeLocked() : Boolean
      {
         return _accountTradeLocked;
      }
      
      public function get nameColor() : String
      {
         return _nameColor;
      }
      
      public function get respectReplenishesLeft() : int
      {
         return _respectReplenishesLeft;
      }
      
      public function get maxRespectPerDay() : int
      {
         return _maxRespectPerDay;
      }
   }
}

