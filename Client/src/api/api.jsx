import axios from "axios";

const URL = "http://localhost:4000";

export const reg_form = async (data) =>{
    try {
        return await axios.post(`${URL}/reg-user`, data)
        
    } catch (error) {
        console.log("Error : ", error);
        
    }
}

export const get_user = async () =>{
    try {
        return await axios.get(`${URL}/user`);
    } catch (error) {
        console.log("Error : ", error);        
    }
}

export const login_user = async (data) =>{
    try {
        return await axios.post(`${URL}/login`, data);
    } catch (error) {
        console.log("Error : ", error);
        
    }
}