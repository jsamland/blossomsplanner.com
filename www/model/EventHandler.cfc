
/**
* Application wide event handler for ORM operations
* @output false
* @implements cfide.orm.IEventHandler
*/
component
{
  /**
  * This method is called before the data is loaded from the DB.
  */
  public void function preLoad( any entity )
  {
    logEvent( "preload", entity );
  }
  
  /**
  * This method is called after the load operation is complete.
  */
  public void function postLoad( any entity )
  {
    logEvent( "postload", entity );
  } 
  
  /**
  * This method is called just before the object is inserted.
  */
  public void function preInsert( any entity )
  {  
    logEvent( "preinsert", arguments.entity );
  }
  
  /**
  * This method is called after the insert operation is complete.
  */
  public void function postInsert( any entity )
  {
    logEvent( "postinsert", arguments.entity );
  }
  
  /**
  * This method is called just before the object is updated. A struct of old data is passed to this method to know the original state of the entity being updated
  */
  public void function preUpdate( any entity, Struct oldData )
  {
     logEvent( "preupdate", arguments.entity );
  }
  
  /**
  * This method will be called after the update operation is complete.
  */
  public void function postUpdate( any entity )
  {
    logEvent( "postupdate", arguments.entity );
  }
  
  /**
  * This method is called before the object is deleted.
  */
  public void function preDelete( any entity )
  {
    logEvent( "predelete", arguments.entity );
  }
  
  /**
  * This method is called after the delete operation is complete.
  */
  public void function postDelete( any entity )
  {
    logEvent( "postdelete", arguments.entity );
  }
  
  /**
  * Writes operation details to the log.
  * @output false
  */
  private void function logEvent( required string event, required cfc )  
  {
    // arguments.event : Name of the event being called.
    // arguments.cfc : The cfc being acted upon.
    var message = "Entity: #getMetaData( arguments.cfc ).fullname#, Event: #arguments.event#";
    Trace( text=message );
    WriteLog( type="event", file="ormevent.log", text=message );
  }
}