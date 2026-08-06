package com.sulake.habbo.communication.messages.parser.inventory.badges
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.messages.incoming.inventory.badges.BadgeInventoryData;
   
   [SecureSWF(rename="true")]
   public class BadgesParser implements IMessageParser
   {
      protected var _totalFragments:int;
      
      protected var _fragmentNo:int;
      
      private var _currentFragment:Map;
      
      public function BadgesParser()
      {
         super();
      }
      
      public function get totalFragments() : int
      {
         return _totalFragments;
      }
      
      public function get fragmentNo() : int
      {
         return _fragmentNo;
      }
      
      public function get currentFragment() : Map
      {
         return _currentFragment;
      }
      
      public function flush() : Boolean
      {
         if(_currentFragment)
         {
            _currentFragment.dispose();
            _currentFragment = null;
         }
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         _totalFragments = param1.readInteger();
         _fragmentNo = param1.readInteger();
         _currentFragment = new Map();
         var _loc5_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc2_ = param1.readInteger();
            _loc3_ = param1.readString();
            _currentFragment.add(_loc3_,new BadgeInventoryData(_loc2_,_loc3_,param1.readInteger(),param1.readInteger()));
            _loc4_++;
         }
         return true;
      }
   }
}

