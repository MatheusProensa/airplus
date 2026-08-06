package com.sulake.habbo.communication.messages.parser.treasurehunt
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class TreasureHuntWinnerInfo
   {
      private var _huntId:String;
      
      private var _userId:int;
      
      private var _userName:String;
      
      private var _userFigure:String;
      
      private var _userGender:String;
      
      public function TreasureHuntWinnerInfo(param1:IMessageDataWrapper)
      {
         super();
         _huntId = param1.readString();
         _userId = param1.readInteger();
         _userName = param1.readString();
         _userFigure = param1.readString();
         _userGender = param1.readString();
      }
      
      public function get huntId() : String
      {
         return _huntId;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get userFigure() : String
      {
         return _userFigure;
      }
      
      public function get userGender() : String
      {
         return _userGender;
      }
   }
}

