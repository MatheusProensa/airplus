package com.sulake.habbo.userclassification
{
   public class UserClassificationData
   {
      public static var UnknownVarFromUserClassificationData_Uint_1:uint = 1;
      
      public static var NEW_USER_CLASSIFICATION:uint = 2;
      
      public static var UnknownVarFromUserClassificationData_Uint_2:uint = 3;
      
      public static var PAYING_USER_CLASSIFICATION:uint = 4;
      
      private var _userId:int;
      
      private var _username:String;
      
      private var _classType:String;
      
      public function UserClassificationData(param1:int, param2:String, param3:String)
      {
         super();
         _userId = param1;
         _username = param2;
         _classType = param3;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get username() : String
      {
         return _username;
      }
      
      public function get classType() : String
      {
         return _classType;
      }
      
      public function toString() : String
      {
         return "[" + _userId + ", " + _username + "] [" + _classType + "]";
      }
   }
}

