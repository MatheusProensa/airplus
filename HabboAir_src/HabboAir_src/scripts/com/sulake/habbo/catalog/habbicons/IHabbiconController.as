package com.sulake.habbo.catalog.habbicons
{
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.habbo.communication.messages.parser.habbicons.UnknownHabboCommunicationMessagesParserHabbicons1;
   import com.sulake.habbo.communication.messages.parser.habbicons.UnknownHabboCommunicationMessagesParserHabbicons2;
   import com.sulake.habbo.communication.messages.parser.habbicons.UnknownHabboCommunicationMessagesParserHabbicons3;
   
   public interface IHabbiconController extends IUnknown
   {
      function get hasLoadedShopData() : Boolean;
      
      function get ownedHabbicons() : Array;
      
      function get recentHabbiconIds() : Array;
      
      function get shopCollections() : Vector.<UnknownHabboCommunicationMessagesParserHabbicons3>;
      
      function get unseenHabbiconCount() : int;
      
      function addEventListener(param1:String, param2:Function) : void;
      
      function removeEventListener(param1:String, param2:Function) : void;
      
      function openHabbiconHub() : void;
      
      function getShopData(param1:Boolean = false) : void;
      
      function getHabbiconInfo(param1:int) : void;
      
      function noteHabbiconUsed(param1:int) : void;
      
      function isUnseenHabbicon(param1:int) : Boolean;
      
      function removeUnseenHabbicon(param1:int) : void;
      
      function resetUnseenHabbicons() : void;
      
      function buyHabbicon(param1:int) : void;
      
      function buyHabbiconCollection(param1:int) : void;
      
      function claimHabbicon(param1:int) : void;
      
      function favoriteHabbicon(param1:int) : void;
      
      function unfavoriteHabbicon(param1:int) : void;
      
      function tryGetOwnedHabbicon(param1:int) : UnknownHabboCommunicationMessagesParserHabbicons1;
      
      function tryGetShopItem(param1:int) : UnknownHabboCommunicationMessagesParserHabbicons2;
   }
}

