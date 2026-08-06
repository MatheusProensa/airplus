package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class BuildersClubPlacementWarningMessageParser implements IMessageParser
   {
      public static var UnknownVarFromBuildersClubPlacementWarningMessageParser_Int_1:int = 0;
      
      public static var UnknownVarFromBuildersClubPlacementWarningMessageParser_Int_2:int = 1;
      
      private var _typeCode:int;
      
      private var _pageId:int;
      
      private var _offerId:int;
      
      private var _extraParam:String;
      
      private var _x:int;
      
      private var _y:int;
      
      private var _direction:int;
      
      private var _wallLocation:String;
      
      public function BuildersClubPlacementWarningMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _typeCode = param1.readInteger();
         _pageId = param1.readInteger();
         _offerId = param1.readInteger();
         _extraParam = param1.readString();
         if(_typeCode == UnknownVarFromBuildersClubPlacementWarningMessageParser_Int_1)
         {
            _x = param1.readInteger();
            _y = param1.readInteger();
            _direction = param1.readInteger();
         }
         else
         {
            _wallLocation = param1.readString();
         }
         return true;
      }
      
      public function get typeCode() : int
      {
         return _typeCode;
      }
      
      public function get pageId() : int
      {
         return _pageId;
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get extraParam() : String
      {
         return _extraParam;
      }
      
      public function get x() : int
      {
         return _x;
      }
      
      public function get y() : int
      {
         return _y;
      }
      
      public function get direction() : int
      {
         return _direction;
      }
      
      public function get wallLocation() : String
      {
         return _wallLocation;
      }
   }
}

