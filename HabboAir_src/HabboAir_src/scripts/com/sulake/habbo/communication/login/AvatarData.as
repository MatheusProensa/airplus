package com.sulake.habbo.communication.login
{
   public class AvatarData
   {
      private var _id:int;
      
      private var _uniqueId:String;
      
      private var _name:String;
      
      private var _motto:String;
      
      private var _figure:String;
      
      private var _gender:String;
      
      private var _head_figure:String;
      
      private var _last_access:int;
      
      private var UnknownVarFromAvatarData_Boolean_1:Boolean;
      
      private var UnknownVarFromAvatarData_Boolean_2:Boolean;
      
      private var _creationTime:String;
      
      public function AvatarData(param1:Object)
      {
         super();
         if(param1 != null)
         {
            _uniqueId = param1.uniqueId;
            _name = param1.name;
            _motto = param1.motto;
            _figure = param1.figureString;
            _gender = param1.gender;
            _last_access = param1.lastWebAccess;
            UnknownVarFromAvatarData_Boolean_1 = param1.habboClubMember == "true";
            UnknownVarFromAvatarData_Boolean_2 = param1.buildersClubMember == "true";
            _creationTime = param1.creationTime;
         }
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
      }
      
      public function get uniqueId() : String
      {
         return _uniqueId;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get motto() : String
      {
         return _motto;
      }
      
      public function get figure() : String
      {
         return _figure;
      }
      
      public function get gender() : String
      {
         return _gender;
      }
      
      public function get head_figure() : String
      {
         return _head_figure;
      }
      
      public function get last_access() : int
      {
         return _last_access;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
   }
}

