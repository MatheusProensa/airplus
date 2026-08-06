package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class HabboSearchResultData
   {
      private var UnknownVarFromHabboSearchResultData_Int_1:int;
      
      private var _avatarName:String;
      
      private var UnknownVarFromHabboSearchResultData_String_1:String;
      
      private var UnknownVarFromHabboSearchResultData_Boolean_1:Boolean;
      
      private var UnknownVarFromHabboSearchResultData_Boolean_2:Boolean;
      
      private var UnknownVarFromHabboSearchResultData_Int_2:int;
      
      private var UnknownVarFromHabboSearchResultData_String_2:String;
      
      private var UnknownVarFromHabboSearchResultData_String_3:String;
      
      private var _realName:String;
      
      public function HabboSearchResultData(param1:IMessageDataWrapper)
      {
         super();
         this.UnknownVarFromHabboSearchResultData_Int_1 = param1.readInteger();
         this._avatarName = param1.readString();
         this.UnknownVarFromHabboSearchResultData_String_1 = param1.readString();
         this.UnknownVarFromHabboSearchResultData_Boolean_1 = param1.readBoolean();
         this.UnknownVarFromHabboSearchResultData_Boolean_2 = param1.readBoolean();
         param1.readString();
         this.UnknownVarFromHabboSearchResultData_Int_2 = param1.readInteger();
         this.UnknownVarFromHabboSearchResultData_String_2 = param1.readString();
         this._realName = param1.readString();
      }
      
      public function get avatarId() : int
      {
         return this.UnknownVarFromHabboSearchResultData_Int_1;
      }
      
      public function get avatarName() : String
      {
         return this._avatarName;
      }
      
      public function get avatarMotto() : String
      {
         return this.UnknownVarFromHabboSearchResultData_String_1;
      }
      
      public function get isAvatarOnline() : Boolean
      {
         return this.UnknownVarFromHabboSearchResultData_Boolean_1;
      }
      
      public function get canFollow() : Boolean
      {
         return this.UnknownVarFromHabboSearchResultData_Boolean_2;
      }
      
      public function get avatarGender() : int
      {
         return this.UnknownVarFromHabboSearchResultData_Int_2;
      }
      
      public function get avatarFigure() : String
      {
         return this.UnknownVarFromHabboSearchResultData_String_2;
      }
      
      public function get lastOnlineDate() : String
      {
         return this.UnknownVarFromHabboSearchResultData_String_3;
      }
      
      public function get realName() : String
      {
         return this._realName;
      }
   }
}

