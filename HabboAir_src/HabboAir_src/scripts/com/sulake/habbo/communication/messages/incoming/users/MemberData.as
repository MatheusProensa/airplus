package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class MemberData
   {
      private static const UnknownConstFromMemberData_Int_1:int = 0;
      
      private static const UnknownConstFromMemberData_Int_2:int = 1;
      
      private static const UnknownConstFromMemberData_Int_3:int = 2;
      
      private static const UnknownConstFromMemberData_Int_4:int = 3;
      
      private static const UnknownConstFromMemberData_Int_5:int = 4;
      
      private var UnknownVarFromMemberData_Int_1:int;
      
      private var _userId:int;
      
      private var _userName:String;
      
      private var _figure:String;
      
      private var _memberSince:String;
      
      public function MemberData(param1:IMessageDataWrapper)
      {
         super();
         UnknownVarFromMemberData_Int_1 = param1.readInteger();
         _userId = param1.readInteger();
         _userName = param1.readString();
         _figure = param1.readString();
         _memberSince = param1.readString();
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get admin() : Boolean
      {
         return UnknownVarFromMemberData_Int_1 == 1;
      }
      
      public function get owner() : Boolean
      {
         return UnknownVarFromMemberData_Int_1 == 0;
      }
      
      public function get member() : Boolean
      {
         return UnknownVarFromMemberData_Int_1 != 3;
      }
      
      public function get blocked() : Boolean
      {
         return UnknownVarFromMemberData_Int_1 == 4;
      }
      
      public function get figure() : String
      {
         return _figure;
      }
      
      public function get memberSince() : String
      {
         return _memberSince;
      }
   }
}

