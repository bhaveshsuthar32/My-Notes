import { useState } from "react";
import Navbar from "../../user/components/navbar";
import { reg_form } from "../../api/api";
import { useNavigate } from "react-router-dom";


const defaultValue = {
    firstname: '',
    lastname: '',
    email: '',
    password: ''

}

function Reg_Form() {
    const [user, setUser] = useState(defaultValue);
    const navigate = useNavigate();

    const handleChange = (e) => {
        setUser({ ...user, [e.target.name]: e.target.value });
    }

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            const response = await reg_form(user);
            if (response.status == 200) {
                console.log('registration done 👍✌️');
                alert('kom brober kre 👍')
                navigate('/');
            }

        } catch (error) {
            if (error.response && error.response.status === 409) {
                alert('Email already exists. Please sign up with another email.');
            } else {
                alert('An error occurred during sign-up. Please try again.');
            }
        }
    }


    //     return (
    //         <>
    //             {/* <Navbar /> */}

    //             <section
    //                 className="min-h-screen bg-cover bg-center flex items-center justify-center"
    //                 style={{
    //                     backgroundImage:
    //                         "url('https://c4.wallpaperflare.com/wallpaper/334/190/550/the-inscription-sticker-minimal-wallpaper-preview.jpg')",
    //                 }}
    //             >
    //                 <div className="grid grid-cols-1 md:grid-cols-6 w-full max-w-4xl bg-white/80 rounded-lg overflow-hidden shadow-lg gap-4">

    //                     {/* LEFT IMAGE */}
    //                     <div className="hidden md:col-span-3 md:block">
    //                         <img
    //                             className="h-full w-full object-cover"
    //                             src="https://w0.peakpx.com/wallpaper/818/565/HD-wallpaper-notes-inscription-cubes-pencil-notebooks.jpg"
    //                             alt="notes"
    //                         />
    //                     </div>

    //                     {/* RIGHT FORM */}
    //                     <div className="col-span-1 md:col-span-3 p-6 grid place-content-center-safe">
    //                         <h1 className="text-xl font-bold mb-4">Registration Form</h1>

    //                         <form onSubmit={handleSubmit}>
    //                             <div>
    //                                 <div>First Name :</div>
    //                                 <input className="border-1 p-1 border-slate-700 border-r-2" type="text" name="firstname" onChange={handleChange} />
    //                             </div>

    //                             <div>
    //                                 <div>Last Name :</div>
    //                                 <input className="border-1 p-1 border-slate-700 border-r-2" type="text" name="lastname" onChange={handleChange} />
    //                             </div>

    //                             <div>
    //                                 <div>Email :</div>
    //                                 <input className="border-1 p-1 border-slate-700 border-r-2" type="text" name="email" onChange={handleChange} />
    //                             </div>

    //                             <div>
    //                                 <div>Password :</div>
    //                                 <input className="border-1 p-1 border-slate-700 border-r-2" type="password" name="password" onChange={handleChange} />
    //                             </div>

    //                             <button
    //                                 type="submit"
    //                                 className="text-white bg-sky-800 px-4 py-1 mt-3 rounded"
    //                             >
    //                                 Done 👍
    //                             </button>
    //                         </form>
    //                     </div>
    //                 </div>
    //             </section>

    //         </>
    //     );
    // }

    // export default Reg_Form;


    return (
        <>
            <Navbar />

            <section
                className="min-h-screen bg-cover bg-center flex items-center justify-center px-4"
                style={{
                    backgroundImage:
                        "url('https://c4.wallpaperflare.com/wallpaper/334/190/550/the-inscription-sticker-minimal-wallpaper-preview.jpg')",
                }}
            >
                <div className="grid grid-cols-1 md:grid-cols-6 w-full max-w-4xl bg-white/80 rounded-lg overflow-hidden shadow-lg">

                    {/* LEFT IMAGE */}
                    <div className="hidden md:col-span-3 md:block">
                        <img
                            className="h-full w-full object-cover"
                            src="https://w0.peakpx.com/wallpaper/818/565/HD-wallpaper-notes-inscription-cubes-pencil-notebooks.jpg"
                            alt="notes"
                        />
                    </div>

                    {/* RIGHT FORM */}
                    <div className="col-span-1 md:col-span-3 flex items-center justify-center p-6">
                        {/* WRAPPER */}
                        <div className="w-full max-w-sm">
                            <h1 className="text-2xl font-bold mb-6 text-center">
                                Registration Form
                            </h1>

                            <form onSubmit={handleSubmit} className="space-y-4">
                                <div>
                                    <label className="block text-sm font-medium mb-1">
                                        First Name
                                    </label>
                                    <input
                                        className="w-full border border-slate-400 px-4 py-2 rounded focus:outline-none focus:ring-2 focus:ring-sky-500"
                                        type="text"
                                        name="firstname"
                                        onChange={handleChange}
                                    />
                                </div>

                                <div>
                                    <label className="block text-sm font-medium mb-1">
                                        Last Name
                                    </label>
                                    <input
                                        className="w-full border border-slate-400 px-4 py-2 rounded focus:outline-none focus:ring-2 focus:ring-sky-500"
                                        type="text"
                                        name="lastname"
                                        onChange={handleChange}
                                    />
                                </div>

                                <div>
                                    <label className="block text-sm font-medium mb-1">
                                        Email
                                    </label>
                                    <input
                                        className="w-full border border-slate-400 px-4 py-2 rounded focus:outline-none focus:ring-2 focus:ring-sky-500"
                                        type="text"
                                        name="email"
                                        onChange={handleChange}
                                    />
                                </div>

                                <div>
                                    <label className="block text-sm font-medium mb-1">
                                        Password
                                    </label>
                                    <input
                                        className="w-full border border-slate-400 px-4 py-2 rounded focus:outline-none focus:ring-2 focus:ring-sky-500"
                                        type="password"
                                        name="password"
                                        onChange={handleChange}
                                    />
                                </div>

                                <button
                                    type="submit"
                                    className="w-full bg-sky-600 hover:bg-sky-700 transition text-white py-2 rounded font-semibold"
                                >
                                    Done 👍
                                </button>
                            </form>
                        </div>
                    </div>

                </div>
            </section>
        </>
    );
}

export default Reg_Form;