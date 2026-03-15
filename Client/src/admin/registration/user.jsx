import { useEffect, useState } from "react";
import { get_user } from "../../api/api";

function User() {
    const [user, setUser] = useState([]);

    useEffect(() => {
        const fetchData = async () => {
            try {
                const response = await get_user();
                setUser(response.data);
            } catch (error) {
                console.log("Error : ", error);
            }
        }

        fetchData();
    }, []);

    return (
        <>
            <div>
                <table>
                    <thead>
                        <tr>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Email</th>
                        </tr>
                    </thead>

                    <tbody>
                        {user.map((userData) => (
                            <tr key={userData._id}>
                                <td>{userData.firstname}</td>
                                <td>{userData.lastname}</td>
                                <td>{userData.email}</td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>

        </>
    )
}

export default User;