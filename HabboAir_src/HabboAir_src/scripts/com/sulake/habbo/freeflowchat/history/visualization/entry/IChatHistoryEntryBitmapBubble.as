package com.sulake.habbo.freeflowchat.history.visualization.entry
{
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public interface IChatHistoryEntryBitmapBubble
   {
      function get bitmap() : BitmapData;
      
      function get overlap() : Rectangle;
      
      function get userIndex() : int;
      
      function get webId() : int;
      
      function get roomId() : int;
      
      function get canIgnore() : Boolean;
      
      function get userName() : String;
   }
}

