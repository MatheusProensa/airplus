package com.sulake.habbo.communication.messages.incoming.callforhelp
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class CfhReportMessage
   {
      public static var UnknownVarFromCfhReportMessage_Int_1:int = 0;
      
      public static var UnknownConstFromHabboGroupDetailsData_Int_5:int = 1;
      
      public static var UnknownVarFromCfhReportMessage_Int_2:int = 2;
      
      public static var UnknownVarFromCfhReportMessage_Int_3:int = 3;
      
      private var _id:int;
      
      private var _creationTime:Number;
      
      private var _userMessage:String;
      
      private var _userCategory:int;
      
      private var _reportedAccountName:String;
      
      private var _closeTime:Number;
      
      private var _sanctioned:Boolean;
      
      private var _sanctionGivenByAutoModeration:Boolean;
      
      private var _appealStatus:int;
      
      private var _appealCreationTime:Number;
      
      private var _appealResolutionTime:Number;
      
      public function CfhReportMessage(param1:IMessageDataWrapper)
      {
         super();
         _id = param1.readLong();
         _creationTime = param1.readLong();
         _userMessage = param1.readString();
         _userCategory = param1.readInteger();
         _reportedAccountName = param1.readString();
         _closeTime = param1.readLong();
         _sanctioned = param1.readBoolean();
         _sanctionGivenByAutoModeration = param1.readBoolean();
         _appealStatus = param1.readByte();
         _appealCreationTime = param1.readLong();
         _appealResolutionTime = param1.readLong();
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get creationTime() : Number
      {
         return _creationTime;
      }
      
      public function get userMessage() : String
      {
         return _userMessage;
      }
      
      public function get userCategory() : int
      {
         return _userCategory;
      }
      
      public function get reportedAccountName() : String
      {
         return _reportedAccountName;
      }
      
      public function get closeTime() : Number
      {
         return _closeTime;
      }
      
      public function get sanctioned() : Boolean
      {
         return _sanctioned;
      }
      
      public function get sanctionGivenByAutoModeration() : Boolean
      {
         return _sanctionGivenByAutoModeration;
      }
      
      public function get appealStatus() : int
      {
         return _appealStatus;
      }
      
      public function get appealCreationTime() : Number
      {
         return _appealCreationTime;
      }
      
      public function get appealResolutionTime() : Number
      {
         return _appealResolutionTime;
      }
   }
}

