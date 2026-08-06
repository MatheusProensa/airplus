package com.sulake.habbo.communication.messages.parser.perk
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PerkAllowancesMessageParser implements IMessageParser
   {
      private var _perks:Vector.<Perk>;
      
      public function PerkAllowancesMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _perks = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:Perk = null;
         _perks = new Vector.<Perk>();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new Perk();
            _loc4_.code = param1.readString();
            _loc4_.errorMessage = param1.readString();
            _loc4_.isAllowed = param1.readBoolean();
            _perks.push(_loc4_);
            _loc3_++;
         }
         return true;
      }
      
      public function getPerks() : Vector.<Perk>
      {
         return _perks;
      }
      
      public function isPerkAllowed(param1:String) : Boolean
      {
         var _loc2_:Perk = getPerk(param1);
         return _loc2_ != null && _loc2_.isAllowed;
      }
      
      public function getPerk(param1:String) : Perk
      {
         for each(var _loc2_ in _perks)
         {
            if(_loc2_.code == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

