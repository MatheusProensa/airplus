package com.sulake.habbo.catalog.guilds
{
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.widgets.GuildSelectorCatalogWidget;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipsMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.users.GetGuildMembershipsMessageComposer;
   
   public class GuildMembershipsController
   {
      private var _catalog:HabboCatalog;
      
      private var UnknownVarFromGuildMembershipsController_GuildSelectorCatalogWidget_1:GuildSelectorCatalogWidget;
      
      public function GuildMembershipsController(param1:HabboCatalog)
      {
         super();
         _catalog = param1;
      }
      
      public function dispose() : void
      {
         _catalog = null;
         UnknownVarFromGuildMembershipsController_GuildSelectorCatalogWidget_1 = null;
      }
      
      public function get catalog() : HabboCatalog
      {
         return _catalog;
      }
      
      public function registerGuildSelectorWidget(param1:GuildSelectorCatalogWidget) : void
      {
         UnknownVarFromGuildMembershipsController_GuildSelectorCatalogWidget_1 = param1;
         _catalog.connection.send(new GetGuildMembershipsMessageComposer());
      }
      
      public function unregisterGuildSelectorWidget(param1:GuildSelectorCatalogWidget) : void
      {
         if(UnknownVarFromGuildMembershipsController_GuildSelectorCatalogWidget_1 == param1)
         {
            UnknownVarFromGuildMembershipsController_GuildSelectorCatalogWidget_1 = null;
         }
         else
         {
            Logger.log("ERROR: Tried to unregister a nonregistered group selector catalog widget");
         }
      }
      
      public function onGuildMembershipsMessageEvent(param1:GuildMembershipsMessageEvent) : void
      {
         var _loc2_:Array = param1.guilds.slice(0,param1.guilds.length);
         if(UnknownVarFromGuildMembershipsController_GuildSelectorCatalogWidget_1 && !UnknownVarFromGuildMembershipsController_GuildSelectorCatalogWidget_1.disposed)
         {
            UnknownVarFromGuildMembershipsController_GuildSelectorCatalogWidget_1.populateAndSelectFavorite(_loc2_);
            UnknownVarFromGuildMembershipsController_GuildSelectorCatalogWidget_1.selectFirstOffer();
         }
      }
      
      public function onGuildVisualSettingsChanged(param1:int) : void
      {
         if(UnknownVarFromGuildMembershipsController_GuildSelectorCatalogWidget_1 != null)
         {
            _catalog.connection.send(new GetGuildMembershipsMessageComposer());
         }
      }
   }
}

