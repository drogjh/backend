package com.blocain.bitms.ignite.startup;

import org.apache.ignite.Ignition;

/** This file was generated by Ignite Web Console (03/21/2018, 11:41) **/
public class ServerNodeSpringStartup
{
    /**
     * Start up node with specified configuration.
     * 
     * @param args Command line arguments, none required.
     * @throws Exception If failed.
     **/
    public static void main(String[] args) throws Exception
    {
        Ignition.start("server.xml");
    }
}